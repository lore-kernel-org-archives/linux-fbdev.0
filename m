From: Juston Li <juston.h.li@gmail.com>
Date: Thu, 25 Jun 2015 21:27:02 +0000
Subject: Re: [PATCH v3 16/19] staging: sm750fb: fix brace placement
Message-Id: <CAFow2F_St7szm9m4y-M66q=h6VafBjUSRwQ=DcfHWSi8kLf5mw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
	<1435163120-3253-16-git-send-email-juston.h.li@gmail.com>
	<20150625121729.GD13366@sudip-PC>
	<CAFow2F_zK42gJ0UoV+GwqLrfsxB2Nqi8kaB7OB+=-APftp=FfQ@mail.gmail.com>
	<20150625203115.GN30834@mwanda>
In-Reply-To: <20150625203115.GN30834@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Jun 25, 2015 at 1:31 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Once you add the else statement, then that kind of doesn't make sense.
> Sudip is right.  It should be:
>
>         } else {
>                 /* commentary about else side */

Yeah, that does make more sense. I'll change it, thanks.

Patchset was responded by Greg's patch bot,  I'll resend when I figure out why.

Regards
Juston
