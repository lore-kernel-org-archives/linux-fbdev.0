From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 20 Jun 2017 20:41:22 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170620204122.GA5603@sudip-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdQ0BoKtbr5m--sZH1yHs=Oo-B577VnxoO8E-0jn0QzCA@mail.gmail.com>
 <20170620200858.GA5287@sudip-laptop>
 <20170620202055.zhleonjxyzzrl5d3@mwanda>
In-Reply-To: <20170620202055.zhleonjxyzzrl5d3@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dan,

On Tue, Jun 20, 2017 at 11:20:55PM +0300, Dan Carpenter wrote:
> That's totally bogus.  Just say you don't know.  It's never a
> reguirement that people fix AMD drivers before they can review code...

Yes, I don't know how drm drivers work, so I blindly follow what has
been done there. And since sm750 ultimately has to be converted to a drm
driver to be taken out of staging, so I will prefer to have similar
changes here.

--
Regards
Sudip
