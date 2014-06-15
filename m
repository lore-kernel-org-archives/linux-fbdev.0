From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 15 Jun 2014 21:52:09 +0000
Subject: [PATCH] video: fbdev: sis: init301.c:  Cleaning up useless if statement
Message-Id: <1402869130-4962-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The same code regardless of the outcome of the if statement. This may of
course be a miss and there should be a difference in the code.
And sets a variable that is missed, a probable cut and paste mistake.

This was partly found using a static code analysis program called cppcheck.

Rickard Strandqvist (1):
  video: fbdev: sis: init301.c:  Cleaning up useless if statement

 drivers/video/fbdev/sis/init301.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

-- 
1.7.10.4

