From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2015 15:38:49 +0000
Subject: Re: [PATCH] staging: sm7xxfb: make smtc_scr_info static
Message-Id: <20150203153849.GA24959@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422953068-12072-1-git-send-email-mperepelitsyn@gmail.com>
 <20150203140401.GA12697@sudip-PC>
In-Reply-To: <20150203140401.GA12697@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Max Perepelitsyn <mperepelitsyn@gmail.com>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org

On Tue, Feb 03, 2015 at 07:34:01PM +0530, Sudip Mukherjee wrote:
> On Tue, Feb 03, 2015 at 02:44:28PM +0600, Max Perepelitsyn wrote:
> > This symbol is never used anywhere else besides sm7xxfb.c
> 
> Hi Greg,
> do i need to do anything about this patch? maybe a tested-by or reviewed-by?

If you test or review it, yes, please add such a line to an email and
reply to the patch with it.

thanks,

greg k-h
