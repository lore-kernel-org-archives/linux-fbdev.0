From: InKi Dae <daeinki@gmail.com>
Subject: Re: [PATCH] added S6E63M0 AMOLED LCD Panel driver.
Date: Wed, 31 Mar 2010 11:41:54 +0900
Message-ID: <90b950fc1003301941r69dc5ce1ida64b590646049a7@mail.gmail.com>
References: <90b950fc1003252024i5ba8989bg95f0a81e8e5e708e@mail.gmail.com>
	 <20100330160257.e5f978a9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100330160257.e5f978a9.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com

Hi Andrew,

all the calls to s6e63m0_panel_send_sequence() would return -EINVAL.
by api_async() of driver/spi/spi.c
so I think that those return values aren't changed to other.

and final step is to check only whether the return value is 0 or not.
if you still think that this code has minor problem or you want it to
be corrected
then I will patch this code to be corrected anytime.

Thank you.

2010/3/31 Andrew Morton <akpm@linux-foundation.org>:
> On Fri, 26 Mar 2010 12:24:24 +0900
> InKi Dae <daeinki@gmail.com> wrote:
>
>> +static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D s6e63m0_panel_send_sequence(lcd, SEQ_PANEL_CONDITI=
ON_SET);
>> + =A0 =A0 ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_DISPLAY_COND=
ITION_SET);
>> + =A0 =A0 ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_GAMMA_SETTIN=
G);
>> + =A0 =A0 ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_ETC_CONDITIO=
N_SET);
>> + =A0 =A0 ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_ACL_ON);
>> + =A0 =A0 ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_ELVSS_ON);
>> +
>> + =A0 =A0 return ret;
>> +}
>
> Well. =A0If one call to s6e63m0_panel_send_sequence() returns -ENOMEM=
 and
> another call returns -EIO (for example), this function will return so=
me
> other, incorrect errno.
>
> Which is a rather minor problem, unless some caller is explicitly
> looking for some particular error code, which doesn't happen often.
>
