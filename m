From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 11 Feb 2015 15:45:10 +0000
Subject: [bug report] potential memory corruption in intelfb_cursor()
Message-Id: <20150211154510.GA31554@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some static checker stuff I'm working on complains:

	drivers/video/fbdev/intelfb/intelfbdrv.c:1678 intelfb_cursor()
	error: overflow detected.  __memcpy() 'dinfo->cursor_src' is 64
	       bytes.  limit = '1-128'

The math here is:

	size = cursor->image.width / 8 * cursor->image.height;

Since the limit for ".width" and ".height" is 32x32 then
"32 / 4 * 32 = 128" but 128 is more than the sizeof(dinfo->cursor_src)
so it creates a buffer overflow warning.

I believe that Smatch is getting 32 as the max size from the tests in
con_font_set().

drivers/video/fbdev/intelfb/intelfbdrv.c

  1632          if (cursor->set & FB_CUR_SETSIZE) {
  1633                  if (cursor->image.width > 64 || cursor->image.height > 64)

Here the limit is assumed to be 64 which would make the overflow worse
than the 32 limit mentioned earlier.

  1634                          return -ENXIO;
  1635  
  1636                  intelfbhw_cursor_reset(dinfo);
  1637          }
  1638  
  1639          if (cursor->set & FB_CUR_SETCMAP) {
  1640                  u32 fg, bg;
  1641  
  1642                  if (dinfo->depth != 8) {
  1643                          fg = dinfo->pseudo_palette[cursor->image.fg_color];
  1644                          bg = dinfo->pseudo_palette[cursor->image.bg_color];
  1645                  } else {
  1646                          fg = cursor->image.fg_color;
  1647                          bg = cursor->image.bg_color;
  1648                  }
  1649  
  1650                  intelfbhw_cursor_setcolor(dinfo, bg, fg);
  1651          }
  1652  
  1653          if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
  1654                  u32 s_pitch = (ROUND_UP_TO(cursor->image.width, 8) / 8);
  1655                  u32 size = s_pitch * cursor->image.height;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Size is calculated here.

  1656                  u8 *dat = (u8 *) cursor->image.data;
  1657                  u8 *msk = (u8 *) cursor->mask;
  1658                  u8 src[64];
  1659                  u32 i;
  1660  
  1661                  if (cursor->image.depth != 1)
  1662                          return -ENXIO;
  1663  
  1664                  switch (cursor->rop) {
  1665                  case ROP_XOR:
  1666                          for (i = 0; i < size; i++)
  1667                                  src[i] = dat[i] ^ msk[i];
  1668                          break;
  1669                  case ROP_COPY:
  1670                  default:
  1671                          for (i = 0; i < size; i++)
  1672                                  src[i] = dat[i] & msk[i];
  1673                          break;
  1674                  }
  1678                  memcpy(dinfo->cursor_src, src, size);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is what Smatch complains about.  The source and dest are 64 bytes
each but it says the user can specify a size which is 128 bytes.

  1679  
  1680                  intelfbhw_cursor_load(dinfo, cursor->image.width,
  1681                                        cursor->image.height, src);
  1682          }

I am a newbie to this code so I don't know if the warning is real or not
or how to fix it.  Sorry.

regards,
dan carpenter
