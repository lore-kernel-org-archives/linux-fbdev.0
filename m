From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 25 Jun 2015 20:31:15 +0000
Subject: Re: [PATCH v3 16/19] staging: sm750fb: fix brace placement
Message-Id: <20150625203115.GN30834@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
 <1435163120-3253-16-git-send-email-juston.h.li@gmail.com>
 <20150625121729.GD13366@sudip-PC>
 <CAFow2F_zK42gJ0UoV+GwqLrfsxB2Nqi8kaB7OB+=-APftp=FfQ@mail.gmail.com>
In-Reply-To: <CAFow2F_zK42gJ0UoV+GwqLrfsxB2Nqi8kaB7OB+=-APftp=FfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Jun 25, 2015 at 08:49:30AM -0700, Juston Li wrote:
> I placed it above the else to make it consistent with the if statement with
> similar comment that the else corresponds to:
> 
> /* Set the primary display control */
> - if (!ctrl)+ if (!ctrl) {

Once you add the else statement, then that kind of doesn't make sense.
Sudip is right.  It should be:

	} else {
		/* commentary about else side */

regards,
dan carpenter

