import os
import json
import base64
import requests
from mylogger import CustomLogger



class GitHubClient:
 
    def __init__(self):
       self.session = self._get_session()
       self.username = self._get_authenticated_user()

    @property
    def _base_url(self):
        return "https://api.github.com"

    @property
    def _get_token(self):
        token = os.getenv("GITHUB_TOKEN")
        if not token:
            raise ValueError("GITHUB_TOKEN environment variable is not set.")
        return token
    
    def _get_session(self):
        session = requests.Session()
        session.verify = False
        headers = self._get_headers()
        session.headers.update(**headers)
        return session
    
    def _get_headers(self):
       
        return {
          "Authorization": f"token {self._get_token}",
          "Accept": "application/vnd.github+json"
        }
    
    def _get_authenticated_user(self):

        try:
            url = f"{self._base_url}/user"
            response = self.session.get(url)
            response.raise_for_status()
            user_info = response.json()
            self.log.debug(f"Authenticated user: {user_info['login']}", color="green")
            return user_info["login"]
        except requests.exceptions.HTTPError as e:
            self.log.error(f"Failed to get authenticated user information")
            raise e
    
    def _sync_fork(self, repo: str) -> dict:

        try:
            url = f"{self._base_url}/repos/{repo}/merges"
            data = {
                "base": "main",
                "head": f"{self.username}:main"
            }
            response = self.session.post(url, json=data)
            response.raise_for_status()
            self.log.info(f"Successfully synced fork for {repo}", color="green")
            return response.json()
        except requests.exceptions.HTTPError as e:
            self.log.error(f"Failed to sync fork for {repo}")
            raise e
