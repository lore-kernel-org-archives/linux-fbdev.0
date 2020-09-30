From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Wed, 30 Sep 2020 07:16:52 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200930071652.GA1152625@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
 <7d341242-9612-d0ee-4b79-e93882fad73f@kernel.org>
In-Reply-To: <7d341242-9612-d0ee-4b79-e93882fad73f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linuxfoundation.org

On Wed, Sep 30, 2020 at 07:26:52AM +0200, Jiri Slaby wrote:
> On 29. 09. 20, 14:34, Peilin Ye wrote:
> > the work in general? I couldn't think of how do we clean up subsystems
> > one by one, while keeping a `console_font` in `struct vc_data`.
> 
> Hi,
> 
> feel free to change struct vc_data's content as you need, of course.
> Only the UAPI _definitions_ have to be preserved (like struct console_font).

Ah, I see. Thank you for the reminder!

Peilin Ye
