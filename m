From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 20 Jun 2017 20:44:18 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170620204418.GB5603@sudip-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdQ0BoKtbr5m--sZH1yHs=Oo-B577VnxoO8E-0jn0QzCA@mail.gmail.com>
 <20170620200858.GA5287@sudip-laptop>
 <20170620202055.zhleonjxyzzrl5d3@mwanda>
 <CAHp75Vd9YGWOU9rDPX5qnU5ia9+xJXVXhCGELeqvUqn1unBL7Q@mail.gmail.com>
In-Reply-To: <CAHp75Vd9YGWOU9rDPX5qnU5ia9+xJXVXhCGELeqvUqn1unBL7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jun 20, 2017 at 11:40:59PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 11:20 PM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> > That's totally bogus.  Just say you don't know.  It's never a
> > reguirement that people fix AMD drivers before they can review code...
> 
> Agree. It's not a cargo cult.
> If there any real thing behind that #ifdef  I would like to hear.

I dont know the real thing behind that. You can hear the real thing if
you send that patch to drm. And that is the only reason I mentioned that.

--
Regards
Sudip
