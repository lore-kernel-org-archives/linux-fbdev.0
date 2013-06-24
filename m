From: jett zhou <jett.zhou@gmail.com>
Date: Mon, 24 Jun 2013 10:08:32 +0000
Subject: Re: [V2 1/7] video: mmp: rb swap setting update for new LCD driver
Message-Id: <CACDDiy-pS-QWdmuc+N+0tijSF=_3YZNwR_PHdUBF_mbhzXY=2w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879533-11017-1-git-send-email-jtzhou@marvell.com>
 <CAMLZHHQ+97f=i3axaFBn9JoOu7Cqo73neqxKYNCfWqwjZ4DfnQ@mail.gmail.com>
In-Reply-To: <CAMLZHHQ+97f=i3axaFBn9JoOu7Cqo73neqxKYNCfWqwjZ4DfnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2013/6/22 Daniel Drake <dsd@laptop.org>:
> On Mon, Jun 10, 2013 at 9:52 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
>> From: Guoqing Li <ligq@marvell.com>
>>
>> We could set rb swap in two modules: DMA controler and interface
>> output after blending.
>> This patch move the panel rbswap requirement setting in later module.
>
> link_config originates from the platform's path config. link_config is
> undocumented and this patch also changes its meaning.
>
> Previously, bit 0 triggered rbswap, and this behaviour is relied upon
> by arch/arm/mach-mmp/ttc_dkb.c
>
> Now bits 27:24 of link_config are used to enable or disable rbswap,
> and link_config bit 0 is ignored. According to the specs for the panel
> path register, valid values for these new bits are 0 (no swap) and 1
> (swap). ttc_dkb has not been updated in this patch series for this new
> behaviour.
>
> I don't understand why rbswap is set to 1 in fmt_to_reg for certain
> RGB formats. The patch description suggests that the rb swapping can
> either be set in fmt_to_reg context (to be written into DMA
> controller) *or* in the interface output. If we are now relying on the
> interface output control to do RB swapping when appropriate, why are
> there still cases when we ask the DMA controller to do the same thing?
>
> I also do not fully understand the requirement for RB swapping. I do
> understand that it changes pixel format from RGB to BGR. What is the
> point? I can imagine that some panels may require such a pixel format,
> however in that case, this configuration should be part of the panel
> configuration, not part of the path configuration as it currently is.
>
> Daniel
 Hi Daniel
       Sorry that the comments of the patch is not so clear.
       As you might know,We can set two rbswap setting, one is based
on pix_fmt to set into DMA input part, the other is to configured in
the output interface part.
       This patch include below change and enhancement:
       1) The input format which support rbswap is based RGB format,
YUV series did not support now. So you can see the patch will change
the rbswap value based on specific RGB format,eg. RGB will set rbswap
= 1, BGR will not set it.
          This part setting is controlled in driver internally, will
not depend on platform configure(link_config) any more.
       2) The output part of rbswap is depend on link_config which is
defined in specific platfrom.
           It will setting bit27:24 of 0x01DC register, eg. DSI output
interface can be controlled by this.
           TTC_dkb does not support dsi, the link_config is no used anymore.
      I will add more this comments in the patch of V3.
Thanks


--

----------------------------------
Best Regards
Jett Zhou
