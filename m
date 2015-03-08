From: =?UTF-8?B?R2llZHJpdXMgU3RhdGtldmnEjWl1cw==?=  <giedrius.statkevicius@gmail.com>
Date: Sun, 08 Mar 2015 13:02:45 +0000
Subject: Re: [PATCH 4/4] staging: sm750fb: fix undeclared function
Message-Id: <54FC4875.1050800@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com> <1425817886-14387-4-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425817886-14387-4-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2015.03.08 14:31, Sudip Mukherjee wrote:
> kbuild test robot reported that for microblaze-allyesconfig
> chan_to_field() and lynxfb_ops_set_par() were not defined. These two
> functions were defined under CONFIG_PM, so for any archtecture if
> CONFIG_PM is not defined we will have this error.
> while moving the lynxfb_suspend() function some very obvious
> checkpatch errors were taken care of.

Such as? If you do you could also fix up the poor things with that
function too such as the comment style here (no space between ; and the
comment):

> +		if (info)
> +			fb_set_suspend(info, 1);/* 1 means do suspend*/
> +

or here (extra unneeded spaces):

> +
> +		/* set chip to sleep mode	*/
> +		if (share->suspend)
> +			(*share->suspend)(share);

-- 
Thanks,
Giedrius
