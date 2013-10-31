From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 31 Oct 2013 10:45:49 +0000
Subject: Re: [PATCH v2] efifb: prevent null-deref when iterating dmi_list
Message-Id: <20131031104549.GZ18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380732056-5387-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1380732056-5387-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-fbdev@vger.kernel.org, James Bates <james.h.bates@gmail.com>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, James Bates <james.h.bates@yahoo.com>

On 18:40 Wed 02 Oct     , David Herrmann wrote:
> The dmi_list array is initialized using gnu designated initializers, and
> therefore may contain fewer explicitly defined entries as there are
> elements in it. This is because the enum above with M_xyz constants
> contains more items than the designated initializer. Those elements not
> explicitly initialized are implicitly set to 0.
> 
> Now efifb_setup() loops through all these array elements, and performs
> a strcmp on each item. For non explicitly initialized elements this will
> be a null pointer:
> 
> This patch swaps the check order in the if statement, thus checks first
> whether dmi_list[i].base is null.
> 
> Signed-off-by: James Bates <james.h.bates@yahoo.com>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

with the simpleDRM arriving next merge I'm wondering if we need to keep it?

Best Regaards,
J.
> ---
> Hi
> 
> As James didn't respond to the last emails, I just rebased the patch and resent
> it. The efi M_xyz constants were moved to x86-sysfb so if anyone wants to remove
> unused bits, please send a separate patch to LKML and x86-ML. This patch just
> fixes the NULL-deref.
> 
> Thanks
> David
> 
>  drivers/video/efifb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 7f9ff75..fcb9500 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -108,8 +108,8 @@ static int efifb_setup(char *options)
>  			if (!*this_opt) continue;
>  
>  			for (i = 0; i < M_UNKNOWN; i++) {
> -				if (!strcmp(this_opt, efifb_dmi_list[i].optname) &&
> -				    efifb_dmi_list[i].base != 0) {
> +				if (efifb_dmi_list[i].base != 0 &&
> +				    !strcmp(this_opt, efifb_dmi_list[i].optname)) {
>  					screen_info.lfb_base = efifb_dmi_list[i].base;
>  					screen_info.lfb_linelength = efifb_dmi_list[i].stride;
>  					screen_info.lfb_width = efifb_dmi_list[i].width;
> -- 
> 1.8.4
> 
