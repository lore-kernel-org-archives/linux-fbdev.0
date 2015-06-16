From: Joe Perches <joe@perches.com>
Date: Tue, 16 Jun 2015 17:33:57 +0000
Subject: Re: [PATCH 7/8] staging: sm7xxfb: move mode table
Message-Id: <1434476037.2689.1.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <1434462131-15191-7-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434462131-15191-7-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, 2015-06-16 at 19:12 +0530, Sudip Mukherjee wrote:
> move vgamode table from the header file to the C file and mark it
> as const.

The slightly odd indentation could be fixed here too.

> +static const struct ModeInit vgamode[] = {
> +	{
> +	 /*  mode#0: 640 x 480  16Bpp  60Hz */
> +	 640, 480, 16, 60,
> +	 /*  Init_MISC */


