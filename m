From: Greg KH <greg@kroah.com>
Date: Tue, 04 Aug 2020 07:37:11 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <20200804073711.GA1749774@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
 <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
 <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
In-Reply-To: <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Kyungtae Kim <kt0755@gmail.com>, Anthony Liguori <aliguori@amazon.com>, b.zolnierkie@samsung.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>, DRI devel <dri-devel@lists.freedesktop.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, Solar Designer <solar@openwall.com>, Yang Yingliang <yangyingliang@huawei.com>, xiao.zhang@windriver.com, Linus Torvalds <torvalds@linux-foundation.org>, =?utf-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>

On Mon, Aug 03, 2020 at 10:08:43AM +0200, Jiri Slaby wrote:
> Hi,
> 
> On 31. 07. 20, 7:22, 张云海 wrote:
> > Remove whitespace at EOL
> 
> I am fine with the patch. However it should be sent properly (inline
> mail, having a PATCH subject etc. -- see
> Documentation/process/submitting-patches.rst). git send-email after git
> format-patch handles most of it.

I'll go fix this all up now "by hand" :(
