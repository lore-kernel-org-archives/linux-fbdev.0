From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Jun 2014 19:00:39 +0000
Subject: re: OMAPDSS: move 'compatible' converter to omapdss driver
Message-Id: <20140610190039.GA30673@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Tomi Valkeinen,

The patch f2dd36ac9974: "OMAPDSS: move 'compatible' converter to
omapdss driver" from May 15, 2014, leads to the following static
checker warning:

	drivers/video/fbdev/omap2/dss/omapdss-boot-init.c:124 omapdss_add_to_list()
	error: potential null dereference 'n'. (kmalloc returns null)

drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
   120  static void __init omapdss_add_to_list(struct device_node *node, bool root)
   121  {
   122          struct dss_conv_node *n = kmalloc(sizeof(struct dss_conv_node),
   123                  GFP_KERNEL);
   124          n->node = node;
   125          n->root = root;
   126          list_add(&n->list, &dss_conv_list);
   127  }
   128  

regards,
dan carpenter
