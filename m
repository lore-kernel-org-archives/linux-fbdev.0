From: InKi Dae <daeinki@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] added S6E63M0 AMOLED LCD Panel 
	driver.
Date: Wed, 31 Mar 2010 11:56:50 +0900
Message-ID: <90b950fc1003301956mf8246f4sd060852dbead1407@mail.gmail.com>
References: <90b950fc1003252024i5ba8989bg95f0a81e8e5e708e@mail.gmail.com>
	 <20100330160257.e5f978a9.akpm@linux-foundation.org>
	 <0D753D10438DA54287A00B027084269763691C3440@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0D753D10438DA54287A00B027084269763691C3440@AUSP01VMBX24.collaborationhost.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

Hi Hertley,

it's a good way.
this way is more clear and also Andrew's concern could be solved.

I'd like to apply it to local repository and then I will send the patch
in the near future.

and Andrew, If you think that Hertley's way is clear then I would make
the patch. maybe it would become second patch.

Thank you.

2010/3/31 H Hartley Sweeten <hartleys@visionengravers.com>:
> On Tuesday, March 30, 2010 4:03 PM, Andrew Morton wrote:
>> On Fri, 26 Mar 2010 12:24:24 +0900
>> InKi Dae <daeinki@gmail.com> wrote:
>>
>>> +static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
>>> +{
>>> + =A0 =A0int ret;
>>> +
>>> + =A0 =A0ret =3D s6e63m0_panel_send_sequence(lcd, SEQ_PANEL_CONDITI=
ON_SET);
>>> + =A0 =A0ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_DISPLAY_COND=
ITION_SET);
>>> + =A0 =A0ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_GAMMA_SETTIN=
G);
>>> + =A0 =A0ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_ETC_CONDITIO=
N_SET);
>>> + =A0 =A0ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_ACL_ON);
>>> + =A0 =A0ret |=3D s6e63m0_panel_send_sequence(lcd, SEQ_ELVSS_ON);
>>> +
>>> + =A0 =A0return ret;
>>> +}
>>
>> Well. =A0If one call to s6e63m0_panel_send_sequence() returns -ENOME=
M and
>> another call returns -EIO (for example), this function will return s=
ome
>> other, incorrect errno.
>>
>> Which is a rather minor problem, unless some caller is explicitly
>> looking for some particular error code, which doesn't happen often.
>
> Why not handle the calls with a loop?
>
> +static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
> +{
> + =A0 =A0 =A0 const unsigned short *init_seq[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_PANEL_CONDITION_SET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_DISPLAY_CONDITION_SET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_GAMMA_SETTING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_ETC_CONDITION_SET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_ACL_ON,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEQ_ELVSS_ON,
> + =A0 =A0 =A0 };
> + =A0 =A0 =A0 int i, ret;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(init_seq); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D s6e63m0_panel_send_sequence(lcd=
, init_seq[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
>
> Note that _s6e63m0_gamma_ctl has the same issue. =A0Actually, the who=
le
> driver has issues with returning errors properly.
>
> Regards,
> Hartley
