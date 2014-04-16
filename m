From: Steven Miao <realmz6@gmail.com>
Date: Wed, 16 Apr 2014 02:48:42 +0000
Subject: Re: [PATCH RESEND] video: bf54x-lq043fb: fix build error
Message-Id: <CAMk6uBn9U2BHCW96pQCrUskUFWq5eVGACJNVM7tO84PzLakLyg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397546239-6650-1-git-send-email-realmz6@kernel.org>
	<534CFFF5.70801@ti.com>
In-Reply-To: <534CFFF5.70801@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steven Miao <realmz6@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, bfin <adi-buildroot-devel@lists.sourceforge.net>, "open list:CAN NETWORK DRIVERS <linux-can@vger.kernel.org>, open
	list:NETWORKING DRIVERS <netdev@vger.kernel.org>, open list" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

Tomi,

On Tue, Apr 15, 2014 at 5:46 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 15/04/14 10:17, Steven Miao wrote:
>> From: Steven Miao <realmz6@gmail.com>
>>
>> include <linux/gpio.h>, drop <asm/gpio.h>
>>
>
> Thanks, queued for 3.15 fixes.
>
> Btw, usually it's good to say in the description what kind of build
> error happens (i.e. copy paste the error).
Thanks. I'll add more description next time.
>
>  Tomi
>
>
-steven
