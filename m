Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8582C375A;
	Sat, 16 May 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778941449; cv=none; b=byndkcIwRzlY91L05qSzcwx1ubqTuBicHRzQoY4tv5B2ozCAXYkLrzDJFrFepLqYY1LKsQ5IZzG5jw+Hd0N/WasFE/VxDSkvrrVMY75sv5mkG39FgAtiodorhuzZEZpWgOCYV0KmkJMn5dpk0JP4PjY5dLwfpyjCU0mUntNz6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778941449; c=relaxed/simple;
	bh=gqMCGQm151Hxsrv0pMo6X5oCLu7WeEnPdt1/Hp1rqbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IpBojBSMiZfxxLfQGzTVhweVOw4kJGYhCAqCQu7ch5rb868HvITtpQmCMbVHHpKL0eQzhf3QtAvwOPRwjxRMaMvmf/4hCydLh89OzN8rEsC/Odae4tjZn61Uh+WL/T5I2r3hbFd9ruJ3yT3tfJ6fi1DybG2SClsPyrHoygB23L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=S35CLtRs; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="S35CLtRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1778941435; x=1779546235; i=len.bao@gmx.us;
	bh=gqMCGQm151Hxsrv0pMo6X5oCLu7WeEnPdt1/Hp1rqbo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S35CLtRsLKotepI95fIcq4huQZTorSzBcqJ2+EJXU5Sr2tpI08rpnR+AcAcvGkkd
	 Yxo9d5LkB2+hi6cN8/GPDUpVlX7Dh0ygb5fU7PgU/wrF/1kgx1MENAOG1Tjl87ANu
	 0AV2uzZG1aM2Hm3GZ2SiWIz35A23ClpvehXTs5m2oTtcz94qdVU5wUKZMRQkXVTNB
	 BywWfrlbNcrhw8k0WsYpMqncHTzZTO7C9kLr0NmBw//M+rjUjVmiV2sdwX/90Cdwl
	 mp1/smwxsTJYQ+p4nEGbScqCy+ypzFKSjLRSsJrAX1nL/rKGBj36Dd07lk51xIWBS
	 zus/04Klwd6g0JGSnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmUHp-1x6d5e0k3l-00hkva; Sat, 16
 May 2026 16:23:55 +0200
From: Len Bao <len.bao@gmx.us>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Bao <len.bao@gmx.us>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Mark g_noaccel, g_nomtrr and g_dualview as __ro_after_init
Date: Sat, 16 May 2026 14:23:21 +0000
Message-ID: <20260516142326.36018-1-len.bao@gmx.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KdCZJDmQ63Ik0X+IVAIoPbqkJCdRRGRLF86LmrYwomC9tJBoagh
 4SQxR/rqDzvhgr6GSLlG0hgwDmwPXwnN9ENHdoxul8lkcGtIqweiy42l80qvzfkgKkbNGZL
 0r8KJBZt5fMKHFKImYiOSV0FMUh0q2XEPtl+S47LEqzRe/rt7rcnoSmXFa+uIkB7WQdAN3E
 YX+0Zgj8TsdbCyXHE6SHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VfOhk5MWQSo=;/tHg413n2pb9xv/BaxEwgeOKWxe
 wTjb+SrDRJVQxlK+ZAK+5aoSnEykIk2pNqTIljpRrpJBsVhQ/E2A/3C6TedRClJqcPYQ2Ws/d
 Kv60ofoJldvyidsD+NxaxokYYw0nj1kOSQUr67ZMkqdyoL8STe20UeXDrIYIgznBLxscrbnGS
 sSL+jAJuBHDX3NiFTDYo//l8WxzTW9GCjidYjVT8O6Vj19aaaMvcilGwPAzjgfgqs6sIxd0ca
 GMefeh3bhXsmc3oY0ilC8EfrmhASBgnAEDjwkO5ftdcJJioqkzy3IFWj5vAVzNKgpSfTB4eYI
 LNCUGIYcxrVxUBMfVTMzY37lobFRvIkIxvgby86he3cygyCJxZtL0kytHrwg91VnMG81Ak5mb
 eN63cn3BPV5EJ8IhTvjBwEpyIyv/6IVZQ3MFIeK18qNx8FvLHjTis5UTPlSD42XxW/P0MbhIu
 URI7ltJUp4Euy0ZclKPbfLinQVyEV6jvarmz6+9qteU/mCsZryoAMvlLGqhgXGt1p2205TSye
 sEt6ntPFSxh/fueTCGvmNnxDa6vHw8zwNN+kmeixC2Ue8Zjf+Mee3oC51MsxKbbmzGmm5OWf2
 pT5599FzmezLwbGZDYt6FtHzF/TvgC2lAALngcmowWFXtm7SFQUECO3fXGak2rAkaViU1vjbJ
 hIP9lSvAVXkYRJfS/zudVdEmJxsgYSAOdVOexSM+gIWT1o9xnskCvZTpUDF/qXvtmpTIEia23
 IBuNPucK/QSIDlSuP1p8nllBXKJa84bv5js2Mxa5vtCI0jn9sDZS2Ks0xAdkPzEgmkB+riO30
 i/U+Cqf3j6PS4MyBeL2NDtz0GZBd+dGOyGTHqVnpzEvQ7W8H0OV/oSNS+A1PI1x3fUQIgLVj4
 jU97exXBDYoelnfwvfYqnQaXWVr5p092rJsoMSHNgvIKCkwRMaYBHcltvW5lKDr0efR+zE9D+
 4N5KiJ+MRhswKFpDU8eI/zLnlOrXMGV0g3L4ztAxd+mC7SHBoMQl4nPQYTd5Ow99CZOsaAveu
 l3xn0qRuCokVkxZdUl+q2VRSJJbaui7XiIbFqXHMnqojxSDJT6rHR3EaEuTTYmJKz8VfAHole
 qVziTO7sEzDsXieyv53Ni3IaV4CP5d+h8MR3UQ70NuAr7wzFG4kV/U1Nk6f0tr4mhZlHFFk2n
 XU0vqP/vdIg3ZIYLeUpKsF+eDDMtoFGjKjTKSSbGBlkuuI4uQxpryIU0wnZTqkIXck1YWexdl
 ACKQUpDi3JexWs3ywA8crd71S3LHXpj7tNGW7/SA/scA7/seLswFpvg9W9G4iZZQMFOsdZhjw
 EvoODU2A50tjT+W6NAy7AXwVQzPOWLvNKaaRhtdhdfKRIWRugKqFxvIr1GqPIKMSE+su0ZhKM
 +NMpLp9WtPjXJuOQ2cChQS5MzsuqEpmMHKFyRfdwAkoqhIV2i+gtmqgXkdAFPkh6jU4xhZ65D
 YeBzDbFm77j8cpJjGJjnvQQmlMLYWkqYPMMWab6j82MgU+75rpFijg3QAKZfUCcAvtt5yKpA6
 D8z7xXor0StZvNmXhEJcwM6/xfW8m4hB8IJ0jcMXCg6DaO4zx7UWDlVYoyg+BXP83mklNXuuM
 9i34pV5OAY2n0Y4RxN6oEhn40LWNoMftt9XUp1xsUGrOx7cLEtvITlpdnbh/+bq1VVjkhOFI6
 2mbUiPH6OO2WV386HnaiCJg/ZPbcKAwgmisv0SKqDzxKgux0In0MjxIRWtiRVBWxmgwLteg9L
 j6aejKbVoxYuy9c3p7bajNb9jocdEZpTFcao+X7UZUoXX9G5V2UE3HR3orziIdm2yCcgHy/8p
 0ulswE5y0+jEJJSLqariLiRBmdYDgGopmHSMZRZpKLm9L6dpEFXGQLDt+XR7Tj45xF1xIEp9O
 3odrUFHwIVj0q6onG3f02PnQQaBd56+l+t/sutR0OlNw9hGom+xiaEGDi4XgIxu03pDLRSCYU
 nzsu8dptiUar+XtkSQX6/ojahvl720W1ibGcFC4DB/vabU4grCq9wA85aaeCT7r+bTaeem68l
 v8Aogsli2fuxr+tjCvEux5DBBVY96qqRjhyWDT9LDWkJaGVNnLm836ebFFeC744Es2tnuSsdj
 dbxCMnrpyA2UKXg7Cd/pOXwRbfka3iLzugx/q/v8ePpVYynE3MWj/ZRLPLzVhwqy1UsTc0X60
 LOd6RWvYJWiOwMaGxTe+TR6+FGXVHjaPZZjwTmMqSmyz2vr3Zl8FE9MZypf0jbZCUh3EL0IYV
 x4WD2bGNTqwZe6MdI1vyABmeDLEpxW8gGAC8NFPgktiz4BnLPZJleWa2ojts1fTyKvqfodYLN
 Ti0FAlI9SkgnVhx7WGNmwd8KUDkIGOufQN+TMzggQ2OLcnb+2vvuCGA8jYIQGzGYn5TP4dNhv
 X9LPMiXHQYCbN7IP1lPe7a63dV9djKt8BRIIonFW3sf+GadNdrizFt8DRbE+QbzevOiMEPjES
 DbfiuC537FtuZUyJ/e/pPs/dCPo3/rtAbUP5WF3oAW75LPAFhTSDThlgFyj2w7fVoi8l5NUVT
 GpOrnL3aZr4E7yA8s0+sNmbOfpH7fixsFte3HCnYXS6e0i2+yg0DcQFU80NDYvRxU7zU7t67q
 wzosw0uAx6KuKPfQaQ2YW8bXUZU9dsoD9rq26HDEp2L/+WYV+HgFzVHd8bHJtUch2bXcwk8J8
 hPtlsFavh4uiE7V9XNWxen4Dk+Pr5Zs0GMFrvCRuwOZDfYFTUwEpgESQ/yYJ+1nyrAOpuksUG
 g/8h0H7SozLerw/coRPCNSp9ssVF/B7eMzlPypbOYEMhLhn/VDmvBUimfsvE3oqtVlJv4Wkzq
 VqtMriNIpiUzV9FWXn00VzpJpene4BjtpV8nnCXWhd3cLcNaQtCLC26RR0u49102AsJTeUTzz
 lF8FQit9J1UoQPPwrOKnISnIIje3SugUjIQoo2exJZX+bojFm1dH7OafUCzsUN5Wbgniu4SbB
 BId22tUb1MBYmcDtpofearIpjSwsZilTgn6beNUGv46KkLZ4RUK3fxolVQcmg5Qvx51gaq5uh
 qyxZTmZaFMmy4HrLvyRzjVAALpQNfhVBiUMOU3OLa5+P4iPrBG/s8kDw0KcQKWsEGEWrJ5/Ua
 H9GclQTyVwxMAmbP4xLbbH/ZgZBinHSDrOuiQ8xNKXkPj/J1NzSCQq56lzYN+OXZSKhQQbK9G
 3biOZ8oMD/+XLxGqMb23U/Qdx5XlsDy2CwHMp20UoDDovOB2Z70Vfnf7q9l3dm7gzU1+voVgx
 DgBFQouZI7AZR20ZV6ZNoKfsRJxTo0QOKoIRmP18S0n/wdmMIGs0wF2kuQl2E2dejWtm7irJn
 FXBeIdSBJoM+akxz1BuKs/OU48dXgdm1euloRbd1FAWjrXJ/IJpYhBic8iY877Jxt33MUunqO
 jjpoEDjp4XBc7GdvnHuPfP19qA4ZvRsTy/oi0CAzeTgpor3SHWBtjhBujL57+D7oEEAuLt8Hx
 cLtSyvr0XrQrSqNhNI+Uu1vvcKCJDIDBPkN5togycpqsRBTJj+Zm3h4h5qhWsrblljmXWy3ys
 0xfhCW4TOLRTrFX7DmYGjemIhiFj1Jq1ri9lD2fXRRV3G20NnjFAo55A9rcw1ImhsMrd/6iyG
 S8mJdukY8f0pzD6PqPNdTiDgQbG7e+lGvlBpwHgxPiIiEj3uj20gOTuBuMnC8+KKXNlG1bjwm
 t7JwFQwVwaO3wj98Qhoz2BkFD4Z00A21+vnaJUNtH9jixcAELR1Tya3L8T2JdABL22u0/VFMz
 GuR0ewYJbvIEHBSYffdRA9v6CSgeHvLjD5MoxFt3sNzJGlAvPxRu+EGSi2zvCURtw3z1tzLgA
 KRbLW156uiN4xY5OlYYZbYZCneVNvtbzMFzpksxP69mmY7HziaBcS8gOd9jVQUJoJgSb+sDWH
 lfPq6+mcg8yViE5KfsU9+iojO5ZMBZExWHdhKlkmBDSLa2sSuaPvAppx1bYyZ+5pgk97Htv3P
 zkpiGAPswzchhBT1XhIBzN5QSNqNDFoDuicJpiPZwHZmeekYBlgvud87Yn95Ac2wkSjO4RX6s
 yA1b+RAiTQjs3vdPP7328jufwCey0G877QeKsRlORG6zhkcpoU+ARNzRL2GxfyhWb423B+qXN
 G+NVa0lhWAlhyYd21bTFOyG8AFV3UsM+073CTE6Bbirnt2sgYYuvqNaCBY4x+DAoWBND/BYXk
 NxhNlo1d6qFeOwZ1a6PVDquKe64jWsQse2v2kQri4XRFOCGtyMkVLv5xkpxINAoWK5utqFctf
 Xfj7S91uMusCzd89+WXwvCSQuUiiQJCcM7XdJn6EE1w1z28DRZuUglR87pMygHEgbbKdyfLsy
 OwV1vrYTrNb8GiAUvqyOl28C4mPkL5nwUUXClPBEghmGizx28GYHmFnbptCusGFW7fh+pe9vV
 i9tdjO5DkE+Q7sDXJiDpzwNjq9eQoobPt6ahnrkdP85oY7/WQBHmvnlbH/e2gcuFrxhdujmEs
 N3AvK6fNbJX56XoS3MivPpwC1ZuLlI5HkPi4k3Xze5LWRmz2V+bfeUn+hCz2+ZTWinRxphJKV
 JycRnEzi2M1ZyshuGY2cLDYXNYu10HAUUH+oA6EgUgSxnrIyAvVtRwZZIRURJZJDi2JeUtO0d
 KvL7Tvgxvvw2IgCU75sjeQuuZhsCqZx6OCb+6gJmGkltMhmhzIsfCzWiCS/896iZIY41uRlXa
 LX4OJ7l+FFP3rhaiRQmPCXmgSwhxei6zrC3Ifg9/VIGHjAmahQ8TjdYt7mWFEAhjRudK0BI+A
 G55h7CAxRsTMw8OsF+/4kvAYX/qSSUQCEYx4oREBCpDhV5/mbLu/yTV8gbB7pkJ76mgVhMbFj
 hNx+/PbdWepLxaxV6JhMdAECBWRfh4/Z8GXnPIqXNqnISAj/3cQIoOh6jrcEaGItOAIiOSzcW
 MzOC88RBdqo06PbwP4esyASSwCuJem6mLrTLnpHtMEsW2/LEUvNWQu6N9Zk/M1Z+8N5RkLqYv
 Tzr6NqsXauLWVp/mzsBVJwTi/89tz9vEz89E+CYinZO+cX7FDmCm7TA3pNSd7v2I0x2Keo9nm
 2lUgJ94z2Z16z/+DS6zzZxm6I6bBPY8lQih/XbT76SHLThqFlkm1IGs/eJuhHtZ//DpRyNpz3
 IQAkUJyEJSGSZC6+QirpC8ddb9eHCDJoZmMkHGr5jM6AjJjUPGv0CeH8RTlVEwEOU6wGbOp7e
 hxhcjKv87cFKQuRZUM4qVIFwQ4nL8vcCCkswdFDIwnXjvSpHdYgqXgmOW12Mkb28g0y6HKx4T
 l0ytIFPAPj+TyPpRnMNWmsavJkiok03q1bClOT9JSVJhnloEca4zCPGY5Rb7t43gbzRakomph
 7dYpsyG8yfjLAKiQAg62Xd4ew+B7EOSU1inL4lWtfVOUpo3WO0PLHjLlWuRVST8ia2/LsM3lB
 TnRzJKUh1edAQAxseq6RPYJX3QujKrxEnM3kh13ziEVDsnVeBbHln0PibPhurHUeI5Uu+PHA7
 sbjTqQGUs7CjXnxHIMd+Cf6GJNVNuhZcdY7k=

The 'g_noaccel', 'g_nomtrr' and 'g_dualview' variables are initialized
only during the init phase in the 'lynxfb_setup' function and never
changed. So, mark them as __ro_after_init.

Signed-off-by: Len Bao <len.bao@gmx.us>
=2D--
 drivers/staging/sm750fb/sm750.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm7=
50.c
index 9f3e3d37e..99f5269f1 100644
=2D-- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -31,12 +31,12 @@
=20
 /* common var for all device */
 static int g_hwcursor =3D 1;
-static int g_noaccel;
-static int g_nomtrr;
+static int g_noaccel __ro_after_init;
+static int g_nomtrr __ro_after_init;
 static const char *g_fbmode[] =3D {NULL, NULL};
 static const char *g_def_fbmode =3D "1024x768-32@60";
 static char *g_settings;
-static int g_dualview;
+static int g_dualview __ro_after_init;
 static char *g_option;
=20
 static const struct fb_videomode lynx750_ext[] =3D {
=2D-=20
2.43.0

