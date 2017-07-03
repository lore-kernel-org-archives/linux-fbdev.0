From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 03 Jul 2017 06:22:29 +0000
Subject: Re: [PATCH] staging: sm750fb: refactor method and fix potential type inconsistence
Message-Id: <20170703062229.GD13523@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170702142335.GA9915@lynnl.wit>
In-Reply-To: <20170702142335.GA9915@lynnl.wit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lynn Lei <lynnl.wit@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, Jul 02, 2017 at 10:27:40PM +0800, Lynn Lei wrote:
> make reg variable typed `u32' not `unsigned int'
> this can fix potential type inconsistence in some platforms

It can?  What platform?

> 
> refactor swPanelPowerSequence() make the code less redundant
> 
> a early check for disp to skip unnecessary delay

Only do one thing per patch please.

thanks,

greg k-h
