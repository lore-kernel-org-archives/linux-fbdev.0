From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Wed, 02 Jul 2014 21:57:11 +0000
Subject: [PATCH] video: fbdev: sh_mipi_dsi.c:  Cleaning up Boolean used in bitwise operation
Message-Id: <1404338232-6708-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Boolean variable is used in bitwise operation.
I personally find that this was pretty ugly, but think a solution like this yet is more correct.

This was found using a static code analysis program called cppcheck

Rickard Strandqvist (1):
  video: fbdev: sh_mipi_dsi.c:  Cleaning up Boolean used in bitwise operation

 drivers/video/fbdev/sh_mipi_dsi.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
1.7.10.4

