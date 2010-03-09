From: Greg KH <gregkh@suse.de>
Date: Tue, 09 Mar 2010 20:58:00 +0000
Subject: Re: [PATCH 3/10] udlfb: pre-allocated urb list helpers
Message-Id: <20100309205800.GA32299@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245155.4353.3298.camel@bernie-aspireone>
In-Reply-To: <1266245155.4353.3298.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, Feb 18, 2010 at 06:22:11PM -0800, Bernie Thompson wrote:
> Hi Greg,
>=20
> On Thu, Feb 18, 2010 at 4:36 PM, Greg KH <gregkh@suse.de> wrote:
> > You can just have the urb framework purge the memory when it is finished
> > automatically, right? =A0What's wrong with that, it should work for what
> > you need.
>=20
> I don't know. Is there a similar driver that's a good example to follow?

Hm, I really don't know, I haven't looked in a while, sorry :(
