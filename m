Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED65C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4684361246
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhDGIbg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241377AbhDGIbf (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 7 Apr 2021 04:31:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69FB96139C;
        Wed,  7 Apr 2021 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617784283;
        bh=57NmromL2JqqMNwKn1lxk2rM0OK+F3IfoxU9XI0Fm6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8mq73w4l+w1W2+7Bspzriwz1/V8mA0tYO1NZhq6lTHeZ6xvAKof6zt8ICWrOoLIX
         VnUP4dVCGMgFTQYCRHN/Mbdi2ExxmdTuRK+8rzn6p1Ekv1YEv7c5b/3mb7JYVAu2Ev
         nqEMUzXeiY9qvdMUf+1hcMjy1ugRJ65GtGt1zUi8=
Date:   Wed, 7 Apr 2021 10:31:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/49] staging: sm750fb: Update dvi_ctrl_device to
 snake case
Message-ID: <YG1t2Y55oyt8qxYi@kroah.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <a3618331115064265bc3bbf8963a84ee8bb57fed.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3618331115064265bc3bbf8963a84ee8bb57fed.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 11:35:56PM -0700, Pavle Rohalj wrote:
> Fix "Avoid CamelCase" checkpatch.pl checks for dvi_ctrl_device structure and
> its usages.
> 
> Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    | 30 ++++++++--------
>  drivers/staging/sm750fb/ddk750_dvi.h    | 20 +++++------
>  drivers/staging/sm750fb/ddk750_sii164.c | 48 ++++++++++++-------------
>  drivers/staging/sm750fb/ddk750_sii164.h | 20 +++++------
>  4 files changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
> index cd564ea40779..db19bf732482 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.c
> +++ b/drivers/staging/sm750fb/ddk750_dvi.c
> @@ -11,20 +11,20 @@
>   * function API. Please set the function pointer to NULL whenever the function
>   * is not supported.
>   */
> -static struct dvi_ctrl_device g_dcftSupportedDviController[] = {
> +static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {

Why the "dcft_" prefix?  We know this is a "dvi control device" by the
fact that the type says it is :)

>  #ifdef DVI_CTRL_SII164
>  	{
> -		.pfnInit = sii164InitChip,
> -		.pfnGetVendorId = sii164GetVendorID,
> -		.pfnGetDeviceId = sii164GetDeviceID,
> +		.pfn_init = sii164_init_chip,
> +		.pfn_get_vendor_id = sii164_get_vendor_id,
> +		.pfn_get_device_id = sii164_get_device_id,
>  #ifdef SII164_FULL_FUNCTIONS
> -		.pfnResetChip = sii164ResetChip,
> -		.pfnGetChipString = sii164GetChipString,
> -		.pfnSetPower = sii164SetPower,
> -		.pfnEnableHotPlugDetection = sii164EnableHotPlugDetection,
> -		.pfnIsConnected = sii164IsConnected,
> -		.pfnCheckInterrupt = sii164CheckInterrupt,
> -		.pfnClearInterrupt = sii164ClearInterrupt,
> +		.pfn_reset_chip = sii164_reset_chip,
> +		.pfn_get_chip_string = sii164_get_chip_string,
> +		.pfn_set_power = sii164_set_power,
> +		.pfn_enable_hot_plug_detection = sii164_enable_hot_plug_detection,
> +		.pfn_is_connected = sii164_is_connected,
> +		.pfn_check_interrupt = sii164_check_interrupt,
> +		.pfn_clear_interrupt = sii164_clear_interrupt,
>  #endif
>  	},
>  #endif
> @@ -41,11 +41,11 @@ int dviInit(unsigned char edge_select,
>  	    unsigned char pll_filter_enable,
>  	    unsigned char pll_filter_value)
>  {
> -	struct dvi_ctrl_device *pCurrentDviCtrl;
> +	struct dvi_ctrl_device *current_dvi_ctrl;
>  
> -	pCurrentDviCtrl = g_dcftSupportedDviController;
> -	if (pCurrentDviCtrl->pfnInit) {
> -		return pCurrentDviCtrl->pfnInit(edge_select,
> +	current_dvi_ctrl = dcft_supported_dvi_controller;
> +	if (current_dvi_ctrl->pfn_init) {
> +		return current_dvi_ctrl->pfn_init(edge_select,
>  						bus_select,
>  						dual_edge_clk_select,
>  						hsync_enable,
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
> index 1c7a565b617a..4ca2591ea94b 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.h
> +++ b/drivers/staging/sm750fb/ddk750_dvi.h
> @@ -27,16 +27,16 @@ typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
>  
>  /* Structure to hold all the function pointer to the DVI Controller. */
>  struct dvi_ctrl_device {
> -	PFN_DVICTRL_INIT		pfnInit;
> -	PFN_DVICTRL_RESETCHIP		pfnResetChip;
> -	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
> -	PFN_DVICTRL_GETVENDORID		pfnGetVendorId;
> -	PFN_DVICTRL_GETDEVICEID		pfnGetDeviceId;
> -	PFN_DVICTRL_SETPOWER		pfnSetPower;
> -	PFN_DVICTRL_HOTPLUGDETECTION	pfnEnableHotPlugDetection;
> -	PFN_DVICTRL_ISCONNECTED		pfnIsConnected;
> -	PFN_DVICTRL_CHECKINTERRUPT	pfnCheckInterrupt;
> -	PFN_DVICTRL_CLEARINTERRUPT	pfnClearInterrupt;
> +	PFN_DVICTRL_INIT		pfn_init;

"pfn_" means "pointer to a function" which is not needed at all.  Just
make this be "init".

And the whole crazy "PFN_DVICTRL_INIT" also is not needed, just put the
real function prototype in here so that we don't have to unwind the mess
to look it up.

So, this line would look like:
	void (*init)(void);

Much smaller, more obvious, matches the kernel coding style, and is way
easier to understand exactly what is happening here.

Typedefs can be used to hide complexity, but here they are just adding
it, for no good reason at all.

I appreciate long patch series being sent out, but maybe make them
smaller so you do not have to redo 49 patches because you are asked to
make a change on the very first patch like here.  Perhaps stick to 20
max for a bit until you get the process down and understand more about
what the kernel programming style is?

thanks,

greg k-h
