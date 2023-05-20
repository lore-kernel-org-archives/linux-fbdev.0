Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3154C77B7D
	for <linux-fbdev@archiver.kernel.org>; Sat, 20 May 2023 14:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjETOq5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 20 May 2023 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETOq4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 20 May 2023 10:46:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0528D110
        for <linux-fbdev@vger.kernel.org>; Sat, 20 May 2023 07:46:54 -0700 (PDT)
Received: (qmail 73303 invoked by uid 1000); 20 May 2023 10:46:54 -0400
Date:   Sat, 20 May 2023 10:46:54 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: udlfb: Use usb_control_msg_send()
Message-ID: <2093306b-1d12-4f10-8dbd-c9ae149d50e3@rowland.harvard.edu>
References: <20230519211625.1072966-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519211625.1072966-1-deller@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 19, 2023 at 11:16:25PM +0200, Helge Deller wrote:
> Use the newly introduced usb_control_msg_send() instead of usb_control_msg()
> when selecting the channel.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  drivers/video/fbdev/udlfb.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index 256d9b61f4ea..dabc30a09f96 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1543,24 +1543,16 @@ static const struct device_attribute fb_device_attrs[] = {
>  static int dlfb_select_std_channel(struct dlfb_data *dlfb)
>  {
>  	int ret;
> -	void *buf;
>  	static const u8 set_def_chn[] = {
>  				0x57, 0xCD, 0xDC, 0xA7,
>  				0x1C, 0x88, 0x5E, 0x15,
>  				0x60, 0xFE, 0xC6, 0x97,
>  				0x16, 0x3D, 0x47, 0xF2  };
> 
> -	buf = kmemdup(set_def_chn, sizeof(set_def_chn), GFP_KERNEL);
> -
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	ret = usb_control_msg(dlfb->udev, usb_sndctrlpipe(dlfb->udev, 0),
> -			NR_USB_REQUEST_CHANNEL,
> +	ret = usb_control_msg_send(dlfb->udev, 0, NR_USB_REQUEST_CHANNEL,
>  			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
> -			buf, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
> -
> -	kfree(buf);
> +			&set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT,
> +			GFP_KERNEL);
> 
>  	return ret;
>  }

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
