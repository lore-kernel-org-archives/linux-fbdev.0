From: Tejun Heo <tj@kernel.org>
Date: Tue, 14 Aug 2012 17:31:24 +0000
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Message-Id: <20120814173124.GO25632@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home>
 <20120809200947.2194e89f@neptune.home>
 <20120813232708.GF25632@google.com>
 <20120814083044.78b401d2@pluto.restena.lu>
In-Reply-To: <20120814083044.78b401d2@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-fbdev@vger.kernel.org

Hello,

On Tue, Aug 14, 2012 at 08:30:44AM +0200, Bruno Pr=E9mont wrote:
> > I'm kinda shooting in the dark but who flushes / cancels
> > fb_info->deferred_work?
>=20
> fb_deferred_io_cleanup() does so and is called by destroy fbops
> (when last reference to fb_info is returned):

I see.  Sorry but just from glancing it I can't really tell what's
going wrong.

Thanks.

--=20
tejun
