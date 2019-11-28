From: Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Date: Thu, 28 Nov 2019 08:31:03 +0000
Subject: Re: [PATCH 13/13] samples: vfio-mdev: constify fb ops
Message-Id: <39B62C70-3E60-48AB-8F11-534EF5B8EFBD@dinechin.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <fc8342eef9fcd2f55c86fcd78f7df52f7c76fa87.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <fc8342eef9fcd2f55c86fcd78f7df52f7c76fa87.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>



> On 27 Nov 2019, at 17:32, Jani Nikula <jani.nikula@intel.com> wrote:
> 
> Now that the fbops member of struct fb_info is const, we can star making
s/star/start/

> the ops const as well.
> 
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
> samples/vfio-mdev/mdpy-fb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
> index 2719bb259653..21dbf63d6e41 100644
> --- a/samples/vfio-mdev/mdpy-fb.c
> +++ b/samples/vfio-mdev/mdpy-fb.c
> @@ -86,7 +86,7 @@ static void mdpy_fb_destroy(struct fb_info *info)
> 		iounmap(info->screen_base);
> }
> 
> -static struct fb_ops mdpy_fb_ops = {
> +static const struct fb_ops mdpy_fb_ops = {
> 	.owner		= THIS_MODULE,
> 	.fb_destroy	= mdpy_fb_destroy,
> 	.fb_setcolreg	= mdpy_fb_setcolreg,
> -- 
> 2.20.1
> 
