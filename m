From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 26 Sep 2018 15:56:25 +0000
Subject: Re: [PATCH] efifb: BGRT: Add nobgrt option
Message-Id: <20180926155627eucas1p1196f8626326439c9b54322fd1f87d7c7~X-kkPYtPF2103421034eucas1p1v@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180912091235.20473-1-hdegoede@redhat.com>
 <CGME20180913065202epcas4p1d575835f474418d8c7939d11523cb9b3@epcas4p1.samsung.com>
 <CANq1E4Tv1JNmk2Jn=Sxv3pgdtO8Pf+2EgX3nYF_pE1L-Uxzqsw@mail.gmail.com>
In-Reply-To: <CANq1E4Tv1JNmk2Jn=Sxv3pgdtO8Pf+2EgX3nYF_pE1L-Uxzqsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Herrmann <dh.herrmann@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


On 09/13/2018 08:51 AM, David Herrmann wrote:
> Hi
>=20
> On Wed, Sep 12, 2018 at 11:12 AM Hans de Goede <hdegoede@redhat.com> wrot=
e:
>>
>> In some setups restoring the BGRT logo is undesirable, allow passing
>> video=EFifb:nobgrt on the kernel commandline to disable it.
>>
>> Cc: David Herrmann <dh.herrmann@gmail.com>
>> Reported-by: David Herrmann <dh.herrmann@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/video/fbdev/efifb.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>=20
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
