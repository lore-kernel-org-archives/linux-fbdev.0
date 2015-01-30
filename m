From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Date: Fri, 30 Jan 2015 08:49:30 +0000
Subject: Re: [PATCH v2] video: fbdev: fix sys_copyarea
Message-Id: <yw1xh9v8bqlh.fsf@unicorn.mansr.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421889589-16362-1-git-send-email-mans@mansr.com>
	<54CB38B6.3010202@ti.com>
In-Reply-To: <54CB38B6.3010202@ti.com> (Tomi Valkeinen's message of "Fri, 30
	Jan 2015 09:54:30 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On 22/01/15 03:19, Mans Rullgard wrote:
>> The sys_copyarea() function performs the same operation as
>> cfb_copyarea() but using normal memory access instead of I/O
>> accessors.  Since the introduction of sys_copyarea(), there
>> have been two fixes to cfb_copyarea():
>>=20
>> - 00a9d699 ("framebuffer: fix cfb_copyarea")
>> - 5b789da8 ("framebuffer: fix screen corruption when copying")
>>=20
>> This patch incorporates the fixes into sys_copyarea() as well.
>>=20
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>> Changed in v2:
>>  - Fixed wrong first/last calculation in bitcpy_rev()
>> ---
>>  drivers/video/fbdev/core/syscopyarea.c | 137 ++++++++++++++++----------=
-------
>>  1 file changed, 65 insertions(+), 72 deletions(-)
>
> Thanks, queued for 3.20.
>
> This makes me wonder, though, if the sys and cfb versions could be
> somehow combined...

I would have done it by #including a common template with different
macro definitions for the memory access operations.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
