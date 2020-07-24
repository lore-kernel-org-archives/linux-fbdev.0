From: Jiri Slaby <jslaby@suse.cz>
Date: Fri, 24 Jul 2020 07:59:15 +0000
Subject: Re: [PATCH] newport_con: vc_color is now in state
Message-Id: <2c7e2be6-526f-0b5d-466b-3e563342f1d9@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <202007241318.wXYkumEO%lkp@intel.com>
 <20200724062735.18229-1-jslaby@suse.cz> <20200724075819.GA3955149@kroah.com>
In-Reply-To: <20200724075819.GA3955149@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 24. 07. 20, 9:58, Greg KH wrote:
> On Fri, Jul 24, 2020 at 08:27:35AM +0200, Jiri Slaby wrote:
>> Since commit 28bc24fc46f9 (vc: separate state), vc->vc_color is known as
>> vc->state.color. Somehow both me and 0-day bot missed this driver during
>> the conversion.
>>
>> So fix the driver now.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: linux-mips@vger.kernel.org
>> ---
>>  drivers/video/console/newport_con.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> You forgot the "Reported-by:" line :(

Ah, I didn't know/notice. Will do next time. Thanks.


-- 
js
suse labs
