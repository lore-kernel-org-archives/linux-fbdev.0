From: Daniel Drake <dsd@laptop.org>
Date: Fri, 21 Jun 2013 16:57:13 +0000
Subject: Re: [V2 1/7] video: mmp: rb swap setting update for new LCD driver
Message-Id: <CAMLZHHQ+97f=i3axaFBn9JoOu7Cqo73neqxKYNCfWqwjZ4DfnQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879533-11017-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370879533-11017-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 9:52 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
> From: Guoqing Li <ligq@marvell.com>
>
> We could set rb swap in two modules: DMA controler and interface
> output after blending.
> This patch move the panel rbswap requirement setting in later module.

link_config originates from the platform's path config. link_config is
undocumented and this patch also changes its meaning.

Previously, bit 0 triggered rbswap, and this behaviour is relied upon
by arch/arm/mach-mmp/ttc_dkb.c

Now bits 27:24 of link_config are used to enable or disable rbswap,
and link_config bit 0 is ignored. According to the specs for the panel
path register, valid values for these new bits are 0 (no swap) and 1
(swap). ttc_dkb has not been updated in this patch series for this new
behaviour.

I don't understand why rbswap is set to 1 in fmt_to_reg for certain
RGB formats. The patch description suggests that the rb swapping can
either be set in fmt_to_reg context (to be written into DMA
controller) *or* in the interface output. If we are now relying on the
interface output control to do RB swapping when appropriate, why are
there still cases when we ask the DMA controller to do the same thing?

I also do not fully understand the requirement for RB swapping. I do
understand that it changes pixel format from RGB to BGR. What is the
point? I can imagine that some panels may require such a pixel format,
however in that case, this configuration should be part of the panel
configuration, not part of the path configuration as it currently is.

Daniel
