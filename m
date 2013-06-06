From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 06 Jun 2013 07:49:49 +0000
Subject: re: uvesafb: Clean up MTRR code
Message-Id: <20130606074949.GA17350@debian>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Andy Lutomirski,

This is a semi-automatic email about new static checker warnings.

The patch 63e28a7a5ffc: "uvesafb: Clean up MTRR code" from May 13, 
2013, leads to the following Smatch complaint:

drivers/video/uvesafb.c:1819 uvesafb_remove()
	 warn: variable dereferenced before check 'par' (see line 1814)

drivers/video/uvesafb.c
  1813			iounmap(info->screen_base);
  1814			arch_phys_wc_del(par->mtrr_handle);
                                         ^^^^^^^^^^^^^^^^
New dereference.

  1815			release_mem_region(info->fix.smem_start, info->fix.smem_len);
  1816			fb_destroy_modedb(info->monspecs.modedb);
  1817			fb_dealloc_cmap(&info->cmap);
  1818	
  1819			if (par) {
                            ^^^
Old check.

  1820				if (par->vbe_modes)
  1821					kfree(par->vbe_modes);

regards,
dan carpenter
