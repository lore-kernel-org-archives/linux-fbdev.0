From: Fabio Erculiani <lxnay@sabayon.org>
Date: Wed, 25 May 2011 18:53:23 +0000
Subject: Re: [PATCH] fbmem: fix race condition between register_framebuffer()
Message-Id: <BANLkTi=5wdmrSCEeHHumcxr5PWXArWtuiw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
	<20110525181917.12cf97b8@neptune.home>
	<BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
	<BANLkTi=Q5EzN+wP9jDNCxCnZBQ0XHOmOhQ@mail.gmail.com>
	<BANLkTikk2BbOWHQN+UPWD71QoM6g-QpHZg@mail.gmail.com>
	<20110525205105.03e2d911@neptune.home>
In-Reply-To: <20110525205105.03e2d911@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Anca Emanuel <anca.emanuel@gmail.com>, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

On Wed, May 25, 2011 at 8:51 PM, Bruno Pr=C3=A9mont
<bonbons@linux-vserver.org> wrote:
>
> Your patch was against 2.6.39 or shortly before as Linus's code
> did introduce the do_ variants of register/unregister/conflict functions.
>
> Bruno
>

I made that patch against the 2.6.39 tag.
Git ain't lying ;-)

--=20
Fabio Erculiani
