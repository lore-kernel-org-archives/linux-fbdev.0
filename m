From: Scot Doyle <lkml14@scotdoyle.com>
Date: Tue, 20 Oct 2015 22:04:22 +0000
Subject: Re: [PATCH] fbcon: initialize blink interval before calling fb_set_par
Message-Id: <alpine.DEB.2.11.1510202110060.1573@local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2505354.BllTl4uaOg@new-mexico>  <alpine.DEB.2.11.1510030350110.20774@local> <3998353.WdEhcyQWSK@new-mexico>  <alpine.DEB.2.11.1510091500100.1816@local> <1445374804.3025.16.camel@kernel.crashing.org>
In-Reply-To: <1445374804.3025.16.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alistair Popple <alistair@popple.id.au>, Pavel Machek <pavel@ucw.cz>, airlied@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 21 Oct 2015, Benjamin Herrenschmidt wrote:
> On Fri, 2015-10-09 at 15:08 +0000, Scot Doyle wrote:
> > Since commit 27a4c827c34ac4256a190cc9d24607f953c1c459
> >     fbcon: use the cursor blink interval provided by vt
> > 
> > a PPC64LE kernel fails to boot when fbcon_add_cursor_timer uses an
> > uninitialized ops->cur_blink_jiffies. Prevent by initializing
> > in fbcon_init before the call to info->fbops->fb_set_par.
> 
> Any reason that hasn't hit upstream (and stable) yet ? This is pretty
> major...

It's currently in the tty-linus branch of Greg's tty tree, so should be 
included in the next rc.
