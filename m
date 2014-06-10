From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Jun 2014 09:04:19 +0000
Subject: re: OMAPDSS: panel sharp-ls037v7dw01 DT support
Message-Id: <20140610090419.GA6154@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Tony Lindgren,

This is a semi-automatic email about new static checker warnings.

The patch be88c16a22ed: "OMAPDSS: panel sharp-ls037v7dw01 DT support"
from May 16, 2014, leads to the following Smatch complaint:

drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c:113 sharp_ls_enable()
	 error: we previously assumed 'ddata->vcc' could be null (see line 105)

drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
   104	
   105		if (ddata->vcc) {
                    ^^^^^^^^^^
Patch introduces a check.

   106			r = regulator_enable(ddata->vcc);
   107			if (r != 0)
   108				return r;
   109		}
   110	
   111		r = in->ops.dpi->enable(in);
   112		if (r) {
   113			regulator_disable(ddata->vcc);
                                          ^^^^^^^^^^
Patch introduces a new dereference and I was too lazy to find out if
an error in ->enable() implies a non-null "ddata->vcc" because I am a
bad person.

   114			return r;
   115		}

regards,
dan carpenter
