From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 17 May 2011 17:43:11 +0000
Subject: Re: [PATCH 2/2] trivial: Changed the printk loglevel when not able to
Message-Id: <BANLkTi=AGbuU-jyhqaSF+yXA3qQuKVLWfA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305653342.2182.15.camel@anish-desktop>
In-Reply-To: <1305653342.2182.15.camel@anish-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: anish <anish198519851985@gmail.com>
Cc: linux@arm.linux.org.uk, lethal@linux-sh.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 17 May 2011 18:29, anish <anish198519851985@gmail.com> wrote:
> When not able to allocate memory we were using KERN_INFO as
> log level in printk so changed to KERN_ERR
> =C2=A0Signed-off-by: anish kumar<anish198519851985@gmail.com>

Maybe KERN_WARN?

--=20
Catalin
