From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Wed, 02 Jul 2014 22:08:34 +0000
Subject: [PATCH] video: fbdev: sis: init301.c:  Cleaning up a potential division by zero
Message-Id: <1404338915-6946-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1402869130-4962-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1402869130-4962-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Guess these ifdef will always be set, but still feel that 1 is a better starting value other than 0 in this case.

This was found using a static code analysis program called cppcheck

Rickard Strandqvist (1):
  video: fbdev: sis: init301.c:  Cleaning up a potential division by zero

 drivers/video/fbdev/sis/init301.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.10.4

