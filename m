From: Tormod Volden <lists.tormod@gmail.com>
Date: Wed, 06 Apr 2011 20:13:42 +0000
Subject: Re: [PATCH] video: s3c-fb: fix checkpatch errors and warning
Message-Id: <BANLkTi=-cvqJ3uWVV9r5SegpYH71Voa68w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301642247-20926-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1301642247-20926-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> On Fri, Apr 01, 2011 at 04:17:27PM +0900, Jingoo Han wrote:
>>
>> Also, following warning is fixed by adding 'platid' variable
>> which can reduce number of lines exceeding 80 characters.
>>
>> WARNING: line over 80 characters

Hi, wouldn't it be better to just break the line somewhere instead of
introducing an extra variable to be used in a single place? Although
the variable will probably be optimized away by the compiler, it adds
unnecessary complexity (and slight confusion) to the code.

Sorry for not commenting on this earlier, I just subscribed to the list.

Best regards,
Tormod
