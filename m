From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 06 Feb 2015 13:47:26 +0000
Subject: Re: [PATCH RFC] video: fbdev: sis: condition with no effect
Message-Id: <20150206134726.GB32696@opentech.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423049774-16305-1-git-send-email-hofrat@osadl.org> <alpine.LNX.2.11.1502052013430.700@localhost> <CAArsGaaTfkYcmL2tbxdbv_Jjwuj6HLE3URxHpq4-ju8wK-Ga7w@mail.gmail.com> <54D46694.7050108@winischhofer.net>
In-Reply-To: <54D46694.7050108@winischhofer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Tormod Volden <lists.tormod@gmail.com>, Scot Doyle <lkml14@scotdoyle.com>, Nicholas Mc Guire <hofrat@osadl.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 06 Feb 2015, Thomas Winischhofer wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Tormod Volden wrote:
> > On Thu, Feb 5, 2015 at 9:45 PM, Scot Doyle wrote:
> >> On Wed, 4 Feb 2015, Nicholas Mc Guire wrote:
> >>> The if and the else branch code are identical - so the condition has no
> >>> effect on the effective code - this patch removes the condition and the
> >>> duplicated code.
> >>>
> >>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> >>> ---
> >>>
> >>> This code has been in here since commit 544393fe584d ("sisfb update") so I guess it is
> >>> safe to simply remove the duplicated code if nobody noticed for 10 years.
> >>>
> >>> Note that the code is not really CodingStyle compliant - the lines inserted were formatted
> >>> to satisfy the coding style but I'm unsure if it is not better to leave it in the
> >>> old format.
> >>>
> >>> Patch was only compile tested with x86_64_defconfig +
> >>> CONFIG_FB_SIS=m, CONFIG_FB_SIS_300=y, CONFIG_FB_SIS_315=y
> >>>
> >>> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
> >>>
> >>>  drivers/video/fbdev/sis/init301.c |    9 ++-------
> >>>  1 file changed, 2 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
> >>> index 295e0de..9533a8ab 100644
> >>> --- a/drivers/video/fbdev/sis/init301.c
> >>> +++ b/drivers/video/fbdev/sis/init301.c
> >>> @@ -7971,13 +7971,8 @@ SiS_SetCHTVReg(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned short
> >>>           }
> >>>        } else {                                               /* ---- PAL ---- */
> >>>           /* We don't play around with FSCI in PAL mode */
> >>> -         if(resindex = 0x04) {
> >>> -            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);       /* loop filter off */
> >>> -            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);       /* ACIV on */
> >>> -         } else {
> >>> -            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);       /* loop filter off */
> >>> -            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);       /* ACIV on */
> >>> -         }
> >>> +       SiS_SetCH70xxANDOR(SiS_Pr, 0x20, 0x00, 0xEF); /* loop filter off */
> >>> +       SiS_SetCH70xxANDOR(SiS_Pr, 0x21, 0x01, 0xFE); /* ACIV on */
> >>>        }
> >>>
> >>>  #endif  /* 300 */
> >> The code covering the PAL case had this redundancy when it was introduced
> >> in Linux 2.4.19.
> >>
> >> Lines 7934-7981 consider three variables: PAL, overscan, and resindex.
> >> Given the "#ifdef 0" block, couldn't the current six sections collapse
> >> into two? One for (!PAL && overscan && resindex=5) and another for the
> >> rest?
> > 
> > Are we sure there isn't a typo in one of the duplicate clauses? Or
> > wrong copy-pasting? Generally I am skeptical to "fixing" code without
> > understanding what is behind or testing it, and just cosmetically
> > brush over it. For now at least it is obvious that there is something
> > wrong. In case (although an unlikely one) someone who understands the
> > code and knows this chip comes along, he would quickly spot this.
> > After your "fixups" this will be all forgotten. Additionally it adds
> > to the impression that this code is being maintained, which is wrong.
> > 
> > I would understand an argument about annoying compiler warnings and
> > the like, but in that case I would prefer to #if 0 it instead of
> > "prettifying" it.
> > 
> > 0.02
> > Tormod
> > 
> 
> The code is partly unfinished due to a lack of hardware to test this
> with. SiS announced SiS+Chrontel 7019 combos at some point but I have
> never seen one. The code was written based on the Chrontel datasheets,
> which weren't clear to some extent, and there wasn't ever any test
> hardware. I don't recall this one exactly, but identical if-else
> statements mean that one alternative is (assumingly) correct, while the
> other is uncertain and/or untested. I left such redunant if-statements
> in the code to remember the conditions and the fact that there is a
> second alternative.
> 
> Considering the long time I'd say it's safe to simplify this.
> 
> A word on other changes I monitored recently: Please bear in mind that
> with video hardware reading and writing registers is not simple like
> reading and writing to memory. Sometimes reading causes an effect in the
> hardware as well (latches, etc), so removing seemingly redundant
> GetReg/SetReg sequences might actually have an effect.
>
thanks for that note - will add that to my checklist of sideffects
for future patches.

thx!
hofrat 
