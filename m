From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Wed, 11 Jan 2012 11:23:33 +0000
Subject: Re: [PATCH] video: s3c-fb: Add device tree support
Message-Id: <CAJuYYwTAtFxDtnDOrOKLwbi+CKZ7CMPZ5QMvQ2=mR4_36qAYPQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
 <004401ccd041$c2f66100$48e32300$%han@samsung.com>
In-Reply-To: <004401ccd041$c2f66100$48e32300$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Dear Mr. Han,

On 11 January 2012 14:46, Jingoo Han <jg1.han@samsung.com> wrote:
> Hi, Thomas.
>
>> -----Original Message-----
>> From: Thomas Abraham [mailto:thomas.abraham@linaro.org]
>> Sent: Tuesday, January 10, 2012 5:02 AM
>> To: linux-fbdev@vger.kernel.org; devicetree-discuss@lists.ozlabs.org
>> Cc: FlorianSchandinat@gmx.de; grant.likely@secretlab.ca; rob.herring@cal=
xeda.com; linux-arm-
>> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; kgene.kim=
@samsung.com;
>> jg1.han@samsung.com; patches@linaro.org
>> Subject: [PATCH] video: s3c-fb: Add device tree support
>>
>> Add device tree based discovery support for Samsung's display controller.
>>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0.../devicetree/bindings/fb/samsung-fb.txt =A0 =A0 =A0 =A0 =A0| =A0103=
 ++++++++++
>> =A0drivers/video/s3c-fb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0209 +++++++++++++++++++-
>> =A02 files changed, 304 insertions(+), 8 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/fb/samsung-fb.txt
>>
>> [...]
>>
>> +- samsung,fimd-bpp: Specifies the bits per pixel. Two values should be
>> + =A0specified in the following order.
>> + =A0 =A0- max-bpp: maximum required bpp for the overlay.
>> + =A0 =A0- default-bpp: bpp supported by the overlay.
>> [...]
>> + =A0 =A0 =A0 =A0 =A0 =A0 fimd-overlay0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 samsung,fimd-htiming =3D <64 1=
6 48 1024>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 samsung,fimd-vtiming =3D <64 1=
6 3 600>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 samsung,fimd-bpp =3D <24 32>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 fimd-overlay1 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 samsung,fimd-htiming =3D <64 1=
6 48 200>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 samsung,fimd-vtiming =3D <64 1=
6 3 100>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 samsung,fimd-bpp =3D <16 32>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> + =A0 =A0 };
> In the above 'samsung-fb.txt', the order is defined as max-bpp and defaul=
t-bpp.
> However, <24 32> and <16 32> seems to be wrong.
> It should be <32 24> and <32 16>, respectively.
> Max bpp would be 32bpp in s3c-fb.

You are right. I will change the order in the documentation as
default-bpp and then max-bpp. Thanks for correction.

Regards,
Thomas.

>
> Best regards,
> Jingoo Han
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-s=
oc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
