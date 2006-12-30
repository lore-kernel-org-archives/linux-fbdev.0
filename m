From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Display class
Date: Fri, 29 Dec 2006 22:32:43 -0500
Message-ID: <200612292232.44122.dtor@insightbb.com>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org> <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org> <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030265AbWL3Dcc@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: James Simmons <jsimmons@infradead.org>
Cc: Miguel Ojeda <maxextreme@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>, linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org

Hi,

On Tuesday 05 December 2006 13:03, James Simmons wrote:
> +int probe_edid(struct display_device *dev, void *data)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct fb_monspecs spec;
> +=A0=A0=A0=A0=A0=A0=A0ssize_t size =3D 45;

const ssize_t size =3D 45?=20

> +
> +=A0=A0=A0=A0=A0=A0=A0dev->name =3D kzalloc(size, GFP_KERNEL);

Why do you need kzalloc here?

> +=A0=A0=A0=A0=A0=A0=A0fb_edid_to_monspecs((unsigned char *) data, &sp=
ec);
> +=A0=A0=A0=A0=A0=A0=A0strcpy(dev->name, spec.manufacturer);

You seem to be overwriting dev->name in the very next line?

> +=A0=A0=A0=A0=A0=A0=A0return snprintf(dev->name, size, "%s %s %s\n", =
spec.manufacturer, spec.monitor, spec.ascii);
>=20

Is result of snprintf interesting to the callers?

--=20
Dmitry
