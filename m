From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 04 Jan 2016 13:25:34 +0000
Subject: re: omapfb: copy omapdss & displays for omapfb
Message-Id: <20160104132534.GA24840@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Tomi Valkeinen,

This is a semi-automatic email about new static checker warnings.

The patch f76ee892a99e: "omapfb: copy omapdss & displays for omapfb" 
from Dec 9, 2015, leads to the following Smatch complaint:

drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:113 sharp_ls_enable()
	 error: we previously assumed 'ddata->vcc' could be null (see line 105)

drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
   104	
   105		if (ddata->vcc) {
                    ^^^^^^^^^^
Check for NULL.

   106			r = regulator_enable(ddata->vcc);
   107			if (r != 0)
   108				return r;
   109		}
   110	
   111		r = in->ops.dpi->enable(in);
   112		if (r) {
   113			regulator_disable(ddata->vcc);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked deref inside function.

   114			return r;
   115		}

regards,
dan carpenter
