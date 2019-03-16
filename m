From: Tom Li <tomli@tomli.me>
Date: Sat, 16 Mar 2019 22:50:49 +0000
Subject: Re: [PATCH] staging: sm759fb: fix camelcase check issue
Message-Id: <20190316225048.GA27446@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316000109.22244-1-jbi.octave@gmail.com>
In-Reply-To: <20190316000109.22244-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Mar 16, 2019 at 12:01:09AM +0000, Jules Irenge wrote:
> Subject: staging: sm759fb: fix camelcase check issue

Thanks for submitting the patch. I'm not a maintainer, but there's a
typo in the mail subject.

This driver is called "sm750fb", not "sm759fb". A misspelled name would
make it difficult for other developers to grep the git log. I suggest you
to correct this typo and resend the patch.

If you are using git, to accomplish this, you could run

    $ git rebase -i [ID OF YOUR COMMIT]~1   # "~1" means one commit before

You would see something like,

    pick xxxxxx: staging: sm759fb: fix camelcase check issue

Change "pick" to "reword", save and exit the editor, and you would be able
to edit your commit message. After fixing it, run

    $ git send-email -v2  #  and so on

To send a new version of the patch, don't forget to include the original
receivers.

If you are not using git, simply fix the mail subject, the new subject should
be:

    [PATCH v2] staging: sm759fb: fix camelcase check issue.

and send it to the original receivers.

The above is a typically convention used by kernel developers when submitting
a patch. I hope it helps.

Cheers,
Tom Li

> Lower case of parameters to fix camelcase warning
>  Issue reported by checkpatch.pl tool
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 4c1f00f551da..6bdf643707c2 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -15,14 +15,14 @@ enum logical_chip_type sm750_get_chip_type(void)
>  	return chip;
>  }
>  
> -void sm750_set_chip_type(unsigned short devId, u8 revId)
> +void sm750_set_chip_type(unsigned short dev_id, u8 rev_id)
>  {
> -	if (devId = 0x718) {
> +	if (dev_id = 0x718) {
>  		chip = SM718;
> -	} else if (devId = 0x750) {
> +	} else if (dev_id = 0x750) {
>  		chip = SM750;
>  		/* SM750 and SM750LE are different in their revision ID only. */
> -		if (revId = SM750LE_REVISION_ID) {
> +		if (rev_id = SM750LE_REVISION_ID) {
>  			chip = SM750LE;
>  			pr_info("found sm750le\n");
>  		}
