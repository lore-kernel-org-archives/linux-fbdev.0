From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 04 Oct 2017 12:50:38 +0000
Subject: [bug report] out of bounds read parsing vmode commandline option
Message-Id: <20171004125038.gkzaemlefrpfa2m2@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This bug predates git but it looks like it might be simple to fix if the
right person looked at the code.

	drivers/video/fbdev/controlfb.c:560 control_setup()
	error: buffer overflow 'control_mac_modes' 20 <= 21

drivers/video/fbdev/controlfb.c
   549  static void __init control_setup(char *options)
   550  {
   551          char *this_opt;
   552  
   553          if (!options || !*options)
   554                  return;
   555  
   556          while ((this_opt = strsep(&options, ",")) != NULL) {
   557                  if (!strncmp(this_opt, "vmode:", 6)) {
   558                          int vmode = simple_strtoul(this_opt+6, NULL, 0);
                                    ^^^^^
We get vmode from the command line.

   559                          if (vmode > 0 && vmode <= VMODE_MAX &&
                                                          ^^^^^^^^^
We check that it's <= 22.

   560                              control_mac_modes[vmode - 1].m[1] >= 0)
                                    ^^^^^^^^^^^^^^^^^
But the problem is that control_mac_modes[] only has 20 elements so the
highest valid index is 19.  vmode - 1 can be up to 21.

   561                                  default_vmode = vmode;
   562                  } else if (!strncmp(this_opt, "cmode:", 6)) {
   563                          int depth = simple_strtoul(this_opt+6, NULL, 0);
   564                          switch (depth) {
   565                           case CMODE_8:
   566                           case CMODE_16:
   567                           case CMODE_32:
   568                                  default_cmode = depth;
   569                                  break;
   570                           case 8:
   571                                  default_cmode = CMODE_8;
   572                                  break;
   573                           case 15:
   574                           case 16:
   575                                  default_cmode = CMODE_16;
   576                                  break;
   577                           case 24:
   578                           case 32:
   579                                  default_cmode = CMODE_32;
   580                                  break;
   581                          }
   582                  }
   583          }
   584  }

regards,
dan carpenter
