From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 29 Sep 2014 08:06:39 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929080637.GB12506@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KDt/GgjP6HVcx58l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum>
In-Reply-To: <20140927235601.19023.31593@quantum>
To: linux-arm-kernel@lists.infradead.org


--KDt/GgjP6HVcx58l
Content-Type: multipart/mixed; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2014 at 04:56:01PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-09-02 02:25:08)
> > On Fri, Aug 29, 2014 at 04:38:14PM +0200, Thierry Reding wrote:
> > > On Fri, Aug 29, 2014 at 04:12:44PM +0200, Maxime Ripard wrote:
> > > > On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
> > > > > I would think the memory should still be reserved anyway to make =
sure
> > > > > nothing else is writing over it. And it's in the device tree anyw=
ay
> > > > > because the driver needs to know where to put framebuffer content=
=2E So
> > > > > the point I was trying to make is that we can't treat the memory =
in the
> > > > > same way as clocks because it needs to be explicitly managed. Whe=
reas
> > > > > clocks don't. The driver is simply too generic to know what to do=
 with
> > > > > the clocks.
> > > >=20
> > > > You agreed on the fact that the only thing we need to do with the
> > > > clocks is claim them. Really, I don't find what's complicated there
> > > > (or not generic).
> > >=20
> > > That's not what I agreed on. What I said is that the only thing we ne=
ed
> > > to do with the clocks is nothing. They are already in the state that
> > > they need to be.
> >=20
> > Claim was probably a poor choice of words, but still. We have to keep
> > the clock running, and both the solution you've been giving and this
> > patch do so in a generic way.
> >=20
> > > > > It doesn't know what frequency they should be running at
> > > >=20
> > > > We don't care about that. Just like we don't care about which
> > > > frequency is the memory bus running at. It will just run at whatever
> > > > frequency is appropriate.
> > >=20
> > > Exactly. And you shouldn't have to care about them at all. Firmware h=
as
> > > already configured the clocks to run at the correct frequencies, and =
it
> > > has made sure that they are enabled.
> > >=20
> > > > > or what they're used for
> > > >=20
> > > > And we don't care about that either. You're not interested in what
> > > > output the framebuffer is setup to use, which is pretty much the sa=
me
> > > > here, this is the same thing here.
> > >=20
> > > That's precisely what I've been saying. The only thing that simplefb
> > > cares about is the memory it should be using and the format of the
> > > pixels (and how many of them) it writes into that memory. Everything
> > > else is assumed to have been set up.
> > >=20
> > > Including clocks.
> >=20
> > We're really discussing in circles here.
> >=20
> > Mike?
> >=20
>=20
> -EHIGHLATENCYRESPONSE
>=20
> I forgot about this thread. Sorry.
>=20
> In an attempt to provide the least helpful answer possible, I will stay
> clear of all of the stuff relating to "how simple should simplefb be"
> and the related reserved memory discussion.
>=20
> A few times in this thread it is stated that we can't prevent unused
> clocks from being disabled. That is only partially true.
>=20
> The clock framework DOES provide a flag to prevent UNUSED clocks from
> being disabled at late_initcall-time by a clock "garbage collector"
> mechanism. Maxime and others familiar with the clock framework are aware
> of this.
>=20
> What the framework doesn't do is to allow for a magic flag in DT, in
> platform_data or elsewhere that says, "don't let me get turned off until
> the right driver claims me". That would be an external or alternative
> method for preventing a clock from being disabled. We have a method for
> preventing clocks from being disabled. It is as follows:
>=20
> struct clk *my_clk =3D clk_get(...);
> clk_prepare_enable(my_clk);
>=20
> That is how it should be done. Period.
>=20
> With that said I think that Luc's approach is very sensible. I'm not
> sure what purpose in the universe DT is supposed to serve if not for
> _this_exact_case_. We have a nice abstracted driver, usable by many
> people. The hardware details of how it is hooked up at the board level
> can all be hidden behind stable DT bindings that everyone already uses.

simplefb doesn't deal at all with hardware details. It simply uses what
firmware has set up, which is the only reason why it will work for many
people. What is passed in via its device tree node is the minimum amount
of information needed to draw something into the framebuffer. Also note
that the simplefb device tree node is not statically added to a DTS file
but needs to be dynamically generated by firmware at runtime.

If we start extending the binding with board-level details we end up
duplicating the device tree node for the proper video device. Also note
that it won't stop at clocks. Other setups will require regulators to be
listed in this device tree node as well so that they don't get disabled
at late_initcall. And the regulator bindings don't provide a method to
list an arbitrary number of clocks in a single property in the way that
the clocks property works.

There may be also resets involved. Fortunately the reset framework is
minimalistic enough not to care about asserting all unused resets at
late_initcall. And other things like power domains may also need to be
kept on.

Passing in clock information via the device tree already requires a non-
trivial amount of code in the firmware. A similar amount of code would
be necessary for each type of resource that needs to be kept enabled. In
addition to the above some devices may also require resources that have
no generic bindings. That just doesn't scale.

The only reasonable thing for simplefb to do is not deal with any kind
of resource at all (except perhaps area that contains the framebuffer
memory).

So how about instead of requiring resources to be explicitly claimed we
introduce something like the below patch? The intention being to give
"firmware device" drivers a way of signalling to the clock framework
that they need rely on clocks set up by firmware and when they no longer
need them. This implements essentially what Mark (CC'ing again on this
subthread) suggested earlier in this thread. Basically, it will allow
drivers to determine the time when unused clocks are really unused. It
will of course only work when used correctly by drivers. For the case of
simplefb I'd expect its .probe() implementation to call the new
clk_ignore_unused() function and once it has handed over control of the
display hardware to the real driver it can call clk_unignore_unused() to
signal that all unused clocks that it cares about have now been claimed.
This is "reference counted" and can therefore be used by more than a
single driver if necessary. Similar functionality could be added for
other resource subsystems as needed.

Thierry

--SkvwRMAIpAhPCcCJ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-clk-Allow-drivers-to-reference-unused-clocks.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 5e2521feab41b71fc80b1b41d4eb6ec967919eed Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Mon, 29 Sep 2014 08:10:49 +0200
Subject: [PATCH] clk: Allow drivers to reference unused clocks

Some drivers are designed to take over a virtual device set up at boot
time by firmware. This can be useful for early boot output on a display
device when no debug serial console is available or for transitioning
=66rom firmware to the Linux kernel in a seemless way.

This type of driver relies on firmware to have set up hardware in a way
that it can scan out a framebuffer using the display hardware. Some of
the resources used by the display hardware (clocks, power supplies, ...)
will typically be turned off (at late_initcall time) by the respective
Linux kernel subsystems unless explicitly claimed by some hardware-
specific driver. However, if this driver is built as a module (loaded
=66rom a filesystem) or defer probing, they will not claim the resources
until long after late_initcall time. This doesn't allow for a seemless
transition.

It can also happen that the hardware-specific driver is never loaded. It
may be that no such driver exists, or it fails to load. Users may even
decide not to load it on purpose, perhaps because it is buggy. Instead
of turning the display off in such cases, a better option is to keep
running with the existing framebuffer, which may also be helpful in
diagnosing why the real driver wasn't loaded.

This patch provides a way for drivers that make use of clocks set up by
firmware to prevent clocks from being automatically disabled. Similarly
a way is provided to signal that they no longer need the clocks (when
the hardware-specific driver has taken over for example).

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/clk.c   | 58 +++++++++++++++++++++++++++++++++++--------------=
----
 include/linux/clk.h | 26 ++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 52d58279a612..2007f10e244c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -486,38 +486,58 @@ out:
 	return;
 }
=20
-static bool clk_ignore_unused;
-static int __init clk_ignore_unused_setup(char *__unused)
+static unsigned long clk_ignore_unused_count =3D 1;
+
+void clk_ignore_unused(void)
 {
-	clk_ignore_unused =3D true;
-	return 1;
+	clk_prepare_lock();
+
+	if (clk_ignore_unused_count =3D=3D 0)
+		pr_warn("clk: unused clocks already disabled\n");
+	else
+		clk_ignore_unused_count++;
+
+	clk_prepare_unlock();
 }
-__setup("clk_ignore_unused", clk_ignore_unused_setup);
=20
-static int clk_disable_unused(void)
+void clk_unignore_unused(void)
 {
 	struct clk *clk;
=20
-	if (clk_ignore_unused) {
-		pr_warn("clk: Not disabling unused clocks\n");
-		return 0;
-	}
-
 	clk_prepare_lock();
=20
-	hlist_for_each_entry(clk, &clk_root_list, child_node)
-		clk_disable_unused_subtree(clk);
+	if (--clk_ignore_unused_count =3D=3D 0) {
+		hlist_for_each_entry(clk, &clk_root_list, child_node)
+			clk_disable_unused_subtree(clk);
=20
-	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
-		clk_disable_unused_subtree(clk);
+		hlist_for_each_entry(clk, &clk_orphan_list, child_node)
+			clk_disable_unused_subtree(clk);
=20
-	hlist_for_each_entry(clk, &clk_root_list, child_node)
-		clk_unprepare_unused_subtree(clk);
+		hlist_for_each_entry(clk, &clk_root_list, child_node)
+			clk_unprepare_unused_subtree(clk);
=20
-	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
-		clk_unprepare_unused_subtree(clk);
+		hlist_for_each_entry(clk, &clk_orphan_list, child_node)
+			clk_unprepare_unused_subtree(clk);
+	}
=20
 	clk_prepare_unlock();
+}
+
+static int __init clk_ignore_unused_setup(char *__unused)
+{
+	clk_ignore_unused();
+	return 1;
+}
+__setup("clk_ignore_unused", clk_ignore_unused_setup);
+
+static int clk_disable_unused(void)
+{
+	clk_unignore_unused();
+
+	if (clk_ignore_unused_count > 0) {
+		pr_warn("clk: Not disabling unused clocks\n");
+		return 0;
+	}
=20
 	return 0;
 }
diff --git a/include/linux/clk.h b/include/linux/clk.h
index afb44bfaf8d1..b587f2b2f2f5 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -106,6 +106,24 @@ int clk_notifier_unregister(struct clk *clk, struct no=
tifier_block *nb);
  */
 long clk_get_accuracy(struct clk *clk);
=20
+/**
+ * clk_ignore_unused - request that unused clocks be kept running
+ *
+ * This function can be used by drivers to request that unused clocks are =
kept
+ * running. It is useful for drivers that take over hardware previously se=
t up
+ * by firmware and which may not explicitly claim all clocks.
+ */
+void clk_ignore_unused(void);
+
+/**
+ * clk_unignore_unused - release unused clocks
+ *
+ * Use this function to undo the effects of clk_ignore_unused(). It is mea=
nt
+ * to be called by drivers for firmware devices after they've handed off t=
he
+ * device to a proper hardware-specific driver.
+ */
+void clk_unignore_unused(void);
+
 #else
=20
 static inline long clk_get_accuracy(struct clk *clk)
@@ -113,6 +131,14 @@ static inline long clk_get_accuracy(struct clk *clk)
 	return -ENOTSUPP;
 }
=20
+static inline void clk_ignore_unused(void)
+{
+}
+
+static inline void clk_unignore_unused(void)
+{
+}
+
 #endif
=20
 /**
--=20
2.1.0


--SkvwRMAIpAhPCcCJ--

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKRMNAAoJEN0jrNd/PrOhrDEP/ix7wAtapGBHEjWW5C3ATpf9
XSbm9y9VPZLqhZfU0nhiqPfT7yoQ0N1aWSho54QNgqCqg2tZPmR+t6P3WaK5Afap
PzJdS6pDyZWNaO+wF8k8tVh+vmkQUUuWteBZjuxiVPfYJwvmh+ibz3Vzloo/hR9R
+0HBQa7lok96PdWKAOgGzgnvzM07tjhD/MmvPPrukEKP+fCYhU716YkAepVFaH/S
+nHBI4Z6g+SfcFUDCj9o5pSS8Mf68MPxPPUH8BcKf2Gy9hDoHjLmeOTjhE+u5y+f
tPldsc8DW4hmuRF9L1aQBFSADB4ucHijcH7q5KarE73YleSqfxeCXGdxOnlbJ67V
0bM0noPesaD2ZggldgJPHfTBgdYD3/wAzZI0Dt+yvE/VRoUJ5sDSlT6axkXArRwH
2FBk53JLb+UnBudyxVYegH6rJnNQij00EQhxse1w/Ia9P/OQw7/XQUbfAknWoioR
yEvBcc2RuNqdKDTquia+6OUhi09pRebbw/9LISe0LMV9TSAw/ruT7Rqo3YYpREBe
M19FXLo3EyBbs6vxyxqIAImeQNGqpBw4VS5Xjlj79eA1Ik+u0ciHjvJwWAQpuFY9
5jHdKHOapHMERRw8XYfUxwU6dmeOAb9z6U9/h2mMQE1s/NHFUTudOGvBiwr2ot9l
WXc5igEjr5wz5byU4t9N
=IhIv
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
