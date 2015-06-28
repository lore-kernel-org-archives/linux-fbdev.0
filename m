From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:43:53 +0000
Subject: [PATCH 00/11] staging: sm750fb: fix checkpatch issues
Message-Id: <1435535044-22042-1-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch series fixes chekpatch.pl errors in sm750fb.

Anatoly Stepanov (11):
  staging: sm750fb: replace spaces with tabs
  staging: sm750fb: remove trailing whitespaces
  staging: sm750fb: insert space between ')' and '{'
  staging: sm750fb: insert space before open parenthesis
  staging: sm750fb: fix indentation of pointer operator
  staging: sm750fb: put open brace on the previous line
  staging: sm750fb: fix indentation in 'else' statements
  staging: sm750fb: fix 'switch and case' indentation
  staging: sm750fb: remove assignment from if condition
  staging: sm750fb: fix open brace in function declaration
  staging: sm750fb: add required spaces around C operators

 drivers/staging/sm750fb/sm750_hw.c | 403 ++++++++++++++++++-------------------
 1 file changed, 198 insertions(+), 205 deletions(-)

-- 
2.1.0

