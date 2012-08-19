From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sun, 19 Aug 2012 16:23:00 +0000
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Message-Id: <20120819182300.63665a0b@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120818154828.0e992bfe@neptune.home>
	<Pine.LNX.4.44L0.1208182001320.25537-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208182001320.25537-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sat, 18 August 2012 Alan Stern wrote:
> On Sat, 18 Aug 2012, Bruno Pr=C3=A9mont wrote:
>=20
> > One thing I just though about, how does usbhid handle the calls to
> > usbhid_submit_report() when hid_hw_stop()/hid_hw_close() have already
> > been called?
>=20
> Looks like they aren't synchronized at all.  That's a bug. =20
> usbhid_submit_report() should check the HID_DISCONNECTED flag.
>=20
> > I will attempt to see if it makes a difference to shortcut my
> > usbhid_submit_report() calls from the point on I have called hid_hw_clo=
se()...
>=20
> I don't know bout hid_hw_close().  Certainly no more reports should be=20
> submitted following usbhid_stop().

Ok, I did just that, prevent new calls to usbhid_submit_report(), after
calling hid_hw_close(), fixed one bug in my code that triggers the NULL
pointer dereference (calling hid_set_drvdata(hdev, NULL) too early).

Now I'm still seeing the bad paging request in _mmx_memcpy(), though rather
sporadically.
The last ones I saw were during remove() around the time of calling hid_hw_=
close()
and hid_hw_stop(). Adding a printk() between the two (at least while picoLCD
is hosting fbcon) makes it very improbably for the bad page to happen.

It looks like low-level driver did free memory in hid_hw_close() for some
in-flight URB and thus things break in following USB interrupt.

From mapping trace information to source it seems:
usbhid/hid-core.c:
static int hid_submit_out(struct hid_device *hid)
{
        struct hid_report *report;
        char *raw_report;
        struct usbhid_device *usbhid =3D hid->driver_data;
        int r;

        report =3D usbhid->out[usbhid->outtail].report;
        raw_report =3D usbhid->out[usbhid->outtail].raw_report;

        usbhid->urbout->transfer_buffer_length =3D ((report->size - 1) >> 3=
) +
                                                 1 + (report->id > 0);
        usbhid->urbout->dev =3D hid_to_usb_dev(hid);
        if (raw_report) {
                memcpy(usbhid->outbuf, raw_report,
                                usbhid->urbout->transfer_buffer_length);
                ^^^^^^^^^^^^^^^_ this is exploding
                kfree(raw_report);
                usbhid->out[usbhid->outtail].raw_report =3D NULL;
        }

        dbg_hid("submitting out urb\n");

        r =3D usb_submit_urb(usbhid->urbout, GFP_ATOMIC);
        if (r < 0) {
                hid_err(hid, "usb_submit_urb(out) failed: %d\n", r);
                return r;
        }
        usbhid->last_out =3D jiffies;
        return 0;
}


Bruno
