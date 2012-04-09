From: Olof Johansson <olof@lixom.net>
Date: Mon, 09 Apr 2012 14:07:15 +0000
Subject: Re: [PATCH] video: exynos: fix build warning and bad pointer deref in dp driver
Message-Id: <CAOesGMiRs8DUTrykePU+SSqsBK52A4x=6M=xt0RLV+NCzDt9pg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1333944982-15859-1-git-send-email-olof@lixom.net>
	<002601cd1632$c34b24b0$49e16e10$%han@samsung.com>
In-Reply-To: <002601cd1632$c34b24b0$49e16e10$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 9, 2012 at 2:25 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>> -----Original Message-----
>> From: Olof Johansson [mailto:olof@lixom.net]
>> Sent: Monday, April 09, 2012 1:16 PM
>>
>> I'm not 100% sure if the fix for 'adjust_request' is correct, since
>> it's uncertain what the original intent was. But it's so clearly an
>> uninitialized pointer dereference that my resolution seems to make sense.
>>
>> drivers/video/exynos/exynos_dp_core.c: In function 'exynos_dp_set_link_train':
>> drivers/video/exynos/exynos_dp_core.c:521:21: warning: 'adjust_request' may be used uninitialized in
>> this function [-Wuninitialized]
>> drivers/video/exynos/exynos_dp_core.c:481:6: note: 'adjust_request' was declared here
>> drivers/video/exynos/exynos_dp_core.c:529:18: warning: 'reg' may be used uninitialized in this function
>> [-Wuninitialized]
>> drivers/video/exynos/exynos_dp_core.c:395:6: note: 'reg' was declared here
>
> My compiler cannot detect this warning.
> What is your compiler version?

gcc version 4.6.2 (GCC)


-Olof
