From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Date: Thu, 22 Jan 2015 01:18:40 +0000
Subject: Re: [PATCH] video: fbdev: fix sys_copyarea
Message-Id: <yw1xlhkvd34f.fsf@unicorn.mansr.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421885875-24145-1-git-send-email-mans@mansr.com>
In-Reply-To: <1421885875-24145-1-git-send-email-mans@mansr.com> (Mans
	Rullgard's message of "Thu, 22 Jan 2015 00:17:55 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Mans Rullgard <mans@mansr.com> writes:

> The sys_copyarea() function performs the same operation as
> cfb_copyarea() but using normal memory access instead of I/O
> accessors.  Since the introduction of sys_copyarea(), there
> have been two fixes to cfb_copyarea():
>
> - 00a9d699 ("framebuffer: fix cfb_copyarea")
> - 5b789da8 ("framebuffer: fix screen corruption when copying")
>
> This patch incorporates the fixes into sys_copyarea() as well.

Scratch that, this patch is broken.  Correct patch coming soon.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
