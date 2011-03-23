From: Dima Zavin <dima@android.com>
Date: Wed, 23 Mar 2011 19:18:52 +0000
Subject: Re: [PATCH 09/20] video: msm: Split out MDP2.2 HW specific code.
Message-Id: <AANLkTimYqxt1q2Ca8meEYdM0yGEHWoBqdTTDU0GXC5ge@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485423-27281-1-git-send-email-carlv@codeaurora.org>
	<1300885912.6117.16.camel@m0nster>
In-Reply-To: <1300885912.6117.16.camel@m0nster>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

>> +config MSM_MDP22
>> + =A0 =A0 =A0 bool
>> + =A0 =A0 =A0 depends on ARCH_MSM7X00A
>> + =A0 =A0 =A0 default y
>> +
>
> You should remove the "default y" and this should be moved to a Kconfig
> under video (shouldn't be added into mach-msm).

Additionally, please have the right MDP version directly 'select'ed by
the ARCH_XXXX definitions instead of doing the 'depends on' business.

--Dima

>
> Daniel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
