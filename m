From: Jiri Kosina <jikos@kernel.org>
Date: Sun, 08 Dec 2019 00:07:02 +0000
Subject: Re: [PATCH v2 11/14] HID: picoLCD: constify fb ops
Message-Id: <nycvar.YFH.7.76.1912080106260.4603@cbobk.fhfr.pm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <8678a9a3566279c881bb4db944850eef35d0a4bb.1575022735.git.jani.nikula@intel.com>
 <20191202094047.34525a7d@aether.lan.sysophe.eu> <871rtji02a.fsf@intel.com>
In-Reply-To: <871rtji02a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

On Thu, 5 Dec 2019, Jani Nikula wrote:

> >> Now that the fbops member of struct fb_info is const, we can start
> >> making the ops const as well.
> >>
> >> v2: fix	typo (Christophe de Dinechin)
> >
> > Fine with me.
> > I don't think going through drm-misc would trigger any conflict, but
> > adding Jiri to CC for the case there was any preference.
> >
> > Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
>=20
> No response, may I proceed with merging this through drm-misc please?

I have been off the grid the past week, sorry for belated response. Feel=20
free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

and take it through your tree.

--=20
Jiri Kosina
SUSE Labs
