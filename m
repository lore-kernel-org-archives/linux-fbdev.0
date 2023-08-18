Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC54C7113D
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Aug 2023 09:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358933AbjHRJC4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358919AbjHRJCa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Aug 2023 05:02:30 -0400
X-Greylist: delayed 1474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:02:03 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF193C3E
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Aug 2023 02:02:02 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 45A2384574; Fri, 18 Aug 2023 09:16:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346595; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=HLitE9ntEbjpQlZ/mxaJqiLjXgQo5jTUnVu1LbslCtAO1MpfA/vc4JyImXylufOVA
         J2yCzh7c26ocS7xTPEF5Bn0mNzk6ftulwy4unw8V/xuHhijfvahWCPmKGPjRx7q+O1
         3rl9911SDuRPhzLoKiPI3poj51v6abA3OUJHUXDSmL0SI7uLBFhAFqmbQ8IctTF527
         DxU4r0KkNk4/yyaArS7spRdV/CE22tuH0KGPJaUdl+LdBNn3YOCaHK4k/m5RamPDCJ
         9SaFXmYb7/8D3PqasjnRb2VgrIUet0LlWVglO9uVOokJli+7AQPqk/bjdvoml0fHDz
         dB2tS/HB8IAdQ==
Received: by mail.leachkin.pl for <linux-fbdev@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cubo.0.pgqf083lac@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-fbdev@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
