From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 17 Dec 2012 12:39:19 +0000
Subject: Re: [patch] OMAPDSS: reading past end of array in dispc_dump_regs()
Message-Id: <20121217123919.GF5032@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20121214150133.GB15839@elgon.mountain>
 <50CF0B5C.9080707@ti.com>
In-Reply-To: <50CF0B5C.9080707@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Dec 17, 2012 at 02:09:00PM +0200, Tomi Valkeinen wrote:
> Why does the static checker think OMAP_DSS_WB is needed in the array?

drivers/video/omap2/dss/dispc.c +3284

  3274  #define DISPC_REG(plane, name, i) name(plane, i)
  3275  #define DUMPREG(plane, name, i) \
  3276          seq_printf(s, "%s_%d(%s)%*s %08x\n", #name, i, p_names[plane], \
  3277          (int)(46 - strlen(#name) - strlen(p_names[plane])), " ", \
  3278          dispc_read_reg(DISPC_REG(plane, name, i)))
  3279  
  3280          /* Video pipeline coefficient registers */
  3281  
  3282          /* start from OMAP_DSS_VIDEO1 */
  3283          for (i = 1; i < dss_feat_get_num_ovls(); i++) {
  3284                  for (j = 0; j < 8; j++)
  3285                          DUMPREG(i, DISPC_OVL_FIR_COEF_H, j);

The logic here is that we pass i to DISPC_OVL_FIR_COEF_H() which
passes i to DISPC_FIR_COEF_H_OFFSET().  Anything higher than
OMAP_DSS_WB will trigger a BUG() in DISPC_FIR_COEF_H_OFFSET().

So it's not rock hard logic at all.

regards,
dan carpenter

