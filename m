From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 13 Aug 2012 16:39:08 +0000
Subject: re: s3fb: fix up DDC build with MTRR disabled.
Message-Id: <20120813163908.GA18576@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

[Sorry this is reall old.  I don't think I've emailed about it before]

Hello Paul Mundt,

This is a semi-automatic email about new static checker warnings.

The patch 4f2970b9f622: "s3fb: fix up DDC build with MTRR disabled." 
from Apr 20, 2011, leads to the following Smatch complaint:

drivers/video/s3fb.c:1411 s3_pci_remove()
	 warn: variable dereferenced before check 'info' (see line 1409)

drivers/video/s3fb.c
  1408		struct fb_info *info = pci_get_drvdata(dev);
  1409		struct s3fb_info __maybe_unused *par = info->par;
                                                       ^^^^^^^^^
New dereference.

  1410	
  1411		if (info) {
                    ^^^^
Old check.

  1412	
  1413	#ifdef CONFIG_MTRR

regards,
dan carpenter

