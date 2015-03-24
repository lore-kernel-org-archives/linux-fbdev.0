From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 24 Mar 2015 09:48:26 +0000
Subject: Re: [PATCH 1/2] staging: sm7xxfb: start using module parameters
Message-Id: <20150324094826.GB6378@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427172609-4318-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1427172609-4318-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 24, 2015 at 10:20:08AM +0530, Sudip Mukherjee wrote:
> add module parameters so that we can configure X and Y resolutions
> and bpp when using this driver as a module.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/staging/sm7xxfb/sm7xxfb.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
> index abdb021..6e9b2aa 100644
> --- a/drivers/staging/sm7xxfb/sm7xxfb.c
> +++ b/drivers/staging/sm7xxfb/sm7xxfb.c
> @@ -1033,6 +1033,24 @@ static int __init sm712fb_init(void)
>  
>  module_init(sm712fb_init);
>  
> +module_param(mode_option, charp, S_IRUGO);
> +
> +MODULE_PARM_DESC(mode_option, "\n\t\tOptions:\n"
> +		 "\t\t0x301 = 640x480-8\n"
> +		 "\t\t0x303 = 800x600-8\n"
> +		 "\t\t0x305 = 1024x768-8\n"
> +		 "\t\t0x307 = 1280x1024-8\n"
> +		 "\t\t0x311 = 640x480-16\n"
> +		 "\t\t0x314 = 800x600-16\n"
> +		 "\t\t0x317 = 1024x768-16\n"
> +		 "\t\t0x31A = 1280x1024-16\n"
> +		 "\t\t0x312 = 640x480-24\n"
> +		 "\t\t0x315 = 800x600-24\n"
> +		 "\t\t0x318 = 1024x768-24\n"
> +		 "\t\t0x31B = 1280x1024-24\n"
> +		 "\t\tUsual example:\n"
> +		 "\t\tinsmod ./sm7xxfb.ko mode_option=\"0x301\"\n");
> +

That's funny :)

And how do you handle multiple devices in the system?

:(

Seriously, never use module parameters for device parameters, they are
two different things.  The framebuffer core has options for handling
modes, why not use them?

And yes, lots of framebuffer drivers do have crazy module parameters,
but that doesn't mean you have to perpetuate the insanity, please do
things properly here.

thanks,

greg k-h
