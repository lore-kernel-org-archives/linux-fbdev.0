From: Olof Johansson <olof@lixom.net>
Date: Mon, 09 Apr 2012 14:05:31 +0000
Subject: Re: [PATCH] video: exynos: fix build warning and bad pointer deref in dp driver
Message-Id: <CAOesGMjH3wwR1k-jurXm4vED8peTLStaQGmQ4Wx4M-bza9Jrcw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1333944982-15859-1-git-send-email-olof@lixom.net>
	<002301cd162d$51bd6b00$f5384100$%han@samsung.com>
In-Reply-To: <002301cd162d$51bd6b00$f5384100$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jingoo Han <jg1.han@samsung.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 9, 2012 at 1:46 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>> -----Original Message-----
>> From: Olof Johansson [mailto:olof@lixom.net]
>> Sent: Monday, April 09, 2012 1:16 PM
>>
>> I'm not 100% sure if the fix for 'adjust_request' is correct, since
>> it's uncertain what the original intent was. But it's so clearly an
>> uninitialized pointer dereference that my resolution seems to make sense.
>>
>> drivers/video/exynos/exynos_dp_core.c: In function 'exynos_dp_set_link_t=
rain':
>> drivers/video/exynos/exynos_dp_core.c:521:21: warning: 'adjust_request' =
may be used uninitialized in
>> this function [-Wuninitialized]
>> drivers/video/exynos/exynos_dp_core.c:481:6: note: 'adjust_request' was =
declared here
>> drivers/video/exynos/exynos_dp_core.c:529:18: warning: 'reg' may be used=
 uninitialized in this function
>> [-Wuninitialized]
>> drivers/video/exynos/exynos_dp_core.c:395:6: note: 'reg' was declared he=
re
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>> =A0drivers/video/exynos/exynos_dp_core.c | =A0 23 +++++++++--------------
>> =A01 file changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exyno=
s/exynos_dp_core.c
>> index 2a4481c..8973e18 100644
>> --- a/drivers/video/exynos/exynos_dp_core.c
>> +++ b/drivers/video/exynos/exynos_dp_core.c
>> @@ -392,24 +392,19 @@ static unsigned int exynos_dp_get_lane_link_traini=
ng(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct exyno=
s_dp_device *dp,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int lane)
>> =A0{
>> - =A0 =A0 u32 reg;
>> -
>> =A0 =A0 =A0 switch (lane) {
>> =A0 =A0 =A0 case 0:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D exynos_dp_get_lane0_link_training(dp);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return exynos_dp_get_lane0_link_training(dp);
>> =A0 =A0 =A0 case 1:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D exynos_dp_get_lane1_link_training(dp);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return exynos_dp_get_lane1_link_training(dp);
>> =A0 =A0 =A0 case 2:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D exynos_dp_get_lane2_link_training(dp);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return exynos_dp_get_lane2_link_training(dp);
>> =A0 =A0 =A0 case 3:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D exynos_dp_get_lane3_link_training(dp);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return exynos_dp_get_lane3_link_training(dp);
>> =A0 =A0 =A0 }
>
> I don't like multi return.

In a small helper function like this there's nothing wrong with it.
Larger functions? Sure.

Adding a default in the switch didn't seem like an improvement to me.
But I'll leave it up to you.

>>
>> - =A0 =A0 return reg;
>> + =A0 =A0 WARN_ON(1);
>> + =A0 =A0 return 0;
>> =A0}
>>
>> =A0static void exynos_dp_reduce_link_rate(struct exynos_dp_device *dp)
>> @@ -489,13 +484,13 @@ static int exynos_dp_process_clock_recovery(struct=
 exynos_dp_device *dp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6, link_stat=
us);
>> =A0 =A0 =A0 lane_count =3D dp->link_train.lane_count;
>>
>> + =A0 =A0 adjust_request =3D link_status + (DPCD_ADDR_ADJUST_REQUEST_LAN=
E0_1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 - DPCD_ADDR_LANE0_1_STATUS);
>> +
>
> It makes the problem. adjust_request will be different.
>
> OK, I understand what you want to do.
> I will send the version 2 patch which is simpler.
>
> Thank you for sending the patch.

Ok, thanks. As I said, I'm not sure what your intent with the second
(else) code path was.


-Olof
