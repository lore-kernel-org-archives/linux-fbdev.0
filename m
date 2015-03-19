From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Mar 2015 12:52:31 +0000
Subject: Re: possible typo in ancient radeon code
Message-Id: <CAMuHMdU=TiQbq8=ur_CZtMFHCPe7qjjKZXcxjyNq1cjKcB1B2w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150319123021.GA12264@mwanda>
In-Reply-To: <20150319123021.GA12264@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

CC BenH

On Thu, Mar 19, 2015 at 1:30 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello FB devs,
>
> This ancient code from 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16,
> 2005, leads to the following static checker warning:

Nah, it's a little bit older (in full-history-linux ;-)

commit 9ff343f3d155aa35f79bae8607d7c4500d7ef848
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Thu Feb 10 16:03:30 2005 -0800

    [PATCH] radeonfb update

>
>         drivers/video/fbdev/aty/radeon_pm.c:417 radeon_pm_enable_dynamic_mode()
>         warn: we tested 'tmp & (1 << 21)' before and it was 'true'
>
> include/video/radeon.h
>   1216  #define MCLK_CNTL__MRDCKA1_SOUTSEL_MASK                 0x0c000000L
>   1217  #define MCLK_CNTL__MRDCKB0_SOUTSEL_MASK                 0x30000000L
>   1218  #define MCLK_CNTL__MRDCKB1_SOUTSEL_MASK                 0xc0000000L
>   1219  #define MCLK_CNTL__R300_DISABLE_MC_MCLKA                (1 << 21)
>   1220  #define MCLK_CNTL__R300_DISABLE_MC_MCLKB                (1 << 21)
>
> These are probably supposed to refer to different bits.
>
>   1221
>   1222  // MCLK_MISC
>
> drivers/video/fbdev/aty/radeon_pm.c
>    411                  /* Some releases of vbios have set DISABLE_MC_MCLKA
>    412                   * and DISABLE_MC_MCLKB bits in the vbios table.  Setting these
>    413                   * bits will cause H/W hang when reading video memory with dynamic
>    414                   * clocking enabled.
>    415                   */
>    416                  if ((tmp & MCLK_CNTL__R300_DISABLE_MC_MCLKA) &&
>    417                      (tmp & MCLK_CNTL__R300_DISABLE_MC_MCLKB)) {
>
> The duplicate check here causes a warning.  I guess it probably doesn't
> matter if no one complains...
>
>    418                          /* If both bits are set, then check the active channels */
>    419                          tmp = INPLL(pllMCLK_CNTL);
>    420                          if (rinfo->vram_width = 64) {
>    421                              if (INREG(MEM_CNTL) & R300_MEM_USE_CD_CH_ONLY)
>    422                                  tmp &= ~MCLK_CNTL__R300_DISABLE_MC_MCLKB;
>    423                              else
>    424                                  tmp &= ~MCLK_CNTL__R300_DISABLE_MC_MCLKA;
>    425                          } else {
>    426                              tmp &= ~(MCLK_CNTL__R300_DISABLE_MC_MCLKA |
>    427                                       MCLK_CNTL__R300_DISABLE_MC_MCLKB);
>    428                          }
>    429                  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
